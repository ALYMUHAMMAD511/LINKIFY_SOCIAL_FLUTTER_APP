import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/comments/comments_screen.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List <Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: const Icon(IconBroken.Arrow___Left_2),
  ),
  titleSpacing: 5.0,
  title: Text(title!),
  actions: actions,
);

Widget mySeparator() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultFormField(context,{
  required TextEditingController? controller,
  TextInputType? type,
  bool isPassword = false,
  required String? labelText,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  final FormFieldValidator<String>? validate,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  bool isClickable = true,
  ValueChanged<String>? onFieldSubmitted}) => TextFormField(
  style: TextStyle(
    color: SocialCubit.get(context).isDark ? Colors.white : Colors.black,
  ),
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color:SocialCubit.get(context).isDark ? Colors.white70: Colors.black54,),
    prefixIcon: Icon(
      prefixIcon,
      color: SocialCubit.get(context).isDark ? Colors.white70: Colors.black54,
    ),
    suffixIcon: IconButton(onPressed: suffixPressed,
        icon: Icon(
          suffixIcon,
          color: SocialCubit.get(context).isDark ? Colors.white70: Colors.black54,
        )
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: SocialCubit.get(context).isDark ? Colors.white: Colors.black54,),
    ),
  ),
  onFieldSubmitted: onFieldSubmitted,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 3.0,
  required VoidCallback? onPressed,
  required String text,
  bool isUpperCase = true,
}) => Container(
  width: width,
  height: 40.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) => TextButton(
  onPressed: onPressed,
  child: Text(
    text.toUpperCase(),
  ),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);

String capitalizeAllWord(String value)
{
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget buildPostItem(PostModel model, context, index) => Card(
    color: SocialCubit.get(context).isDark ? HexColor('333739') : Colors.white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children:
                      [
                        Text(
                          '${model.name}',
                          style: TextStyle(
                            color: SocialCubit.get(context).isDark ? Colors.white : Colors.black,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        height: 1.4,
                        color: SocialCubit.get(context).isDark ? Colors.white70 : Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 10.0,
              top: 5.0,
            ),
            child: Container(
              width: double.infinity,
            ),
          ),
          if(model.postImage != '')
            Padding(
            padding: const EdgeInsetsDirectional.only(top: 15.0),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage('${model.postImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children:
                        [
                          Row(
                            children:
                            [
                              const Icon(
                                IconBroken.Heart,
                                size: 17.0,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes![index]}',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: SocialCubit.get(context).isDark ? Colors.white70 : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:
                        [
                          Row(
                            children:
                            [
                              const Icon(
                                IconBroken.Chat,
                                size: 17.0,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Comments',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: SocialCubit.get(context).isDark ? Colors.white70 : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Write a comment ...',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: SocialCubit.get(context).isDark ? Colors.white70 : Colors.black45,
                          ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    navigateTo(
                        context, CommentsScreen(postId: SocialCubit.get(context).postsId![index]));
                  },
                ),
              ),
              InkWell(
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postsId![index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children:
                    [
                      Row(
                        children:
                        [
                          const Icon(
                            IconBroken.Heart,
                            size: 17.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: SocialCubit.get(context).isDark ? Colors.white70 : Colors.black45,
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    )
);

Widget buildReceiverMessage(MessageModel messageModel) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: const BorderRadiusDirectional.only(
        topStart: Radius.circular(10.0),
        topEnd: Radius.circular(10.0),
        bottomEnd: Radius.circular(10.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 10.0,
    ),
    child: Text(
      '${messageModel.text}',
    ),
  ),
);

Widget buildSenderMessage(MessageModel messageModel) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
    decoration: const BoxDecoration(
      color: defaultColor,
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(10.0),
        topEnd: Radius.circular(10.0),
        bottomStart: Radius.circular(10.0),
      ),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 5.0,
      horizontal: 10.0,
    ),
    child: Text(
      '${messageModel.text}',
    ),
  ),
);