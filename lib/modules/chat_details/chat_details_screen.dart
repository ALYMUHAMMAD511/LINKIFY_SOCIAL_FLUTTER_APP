import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget
{
  UserModel? userModel;
  var messageController = TextEditingController();

  ChatDetailsScreen({super.key, this.userModel});

  @override
  Widget build(BuildContext context)
  {
    return Builder(
      builder: (BuildContext context)
      {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer <SocialCubit, SocialStates>(
          listener: (context, state){},
          builder: (context, state)
          {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(userModel!.name!),
                  ],
                ),
                titleSpacing: 0.0,
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index)
                          {
                            var message = SocialCubit.get(context).messages[index];

                            if(SocialCubit.get(context).userModel!.uId == message.senderId)
                            {
                              return buildSenderMessage(message);
                            }
                            else
                              {
                                return buildReceiverMessage(message);
                              }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children:
                          [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type your message here ...',
                                      hintStyle: TextStyle(
                                        color: SocialCubit.get(context).isDark ? Colors.white54 : Colors.black45,
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed:()
                                {
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: userModel!.uId!,
                                    text: messageController.text,
                                    dateTime: DateTime.now().toString(),
                                  );
                                },
                                minWidth: 1.0,
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }
}