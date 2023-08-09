import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import '../../cubit/cubit.dart';
import '../../models/user_model.dart';
import '../chat_details/chat_details_screen.dart';

class ChatsScreen extends StatelessWidget
{
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return  ConditionalBuilder(
          condition: SocialCubit.get(context).allUsers!.isNotEmpty,
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
          builder: (context)=>ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildChatItem(SocialCubit.get(context).allUsers![index],context),
            separatorBuilder:(context,index)=>mySeparator(),
            itemCount:SocialCubit.get(context).allUsers!.length,
          ),
        );
      },
    );
  }
  Widget buildChatItem(UserModel? model,context)=> InkWell(
    onTap: ()
    {
      navigateTo(context,ChatDetailsScreen(userModel: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
          children:
      [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage('${model!.image}'),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            height: 1.4,
            color: SocialCubit.get(context).isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
      ),
    ),
  );
}