import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../../models/comments_model.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatelessWidget
{
  final String postId;

  CommentsScreen({Key? key, required this.postId}) : super(key: key);

  final commentController = TextEditingController();
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getComments(postId: postId);

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Comments'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ConditionalBuilder(
                    condition:SocialCubit.get(context).comments.isNotEmpty,
                    builder: (context) => Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildCommentItem(context,
                              SocialCubit.get(context).comments[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10.0,
                        ),
                        itemCount: SocialCubit.get(context).comments.length,
                      ),
                    ),
                    fallback:(context) => Expanded(
                        child: Center(
                            child: Text(
                              'No comments',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: SocialCubit.get(context).isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                        ),
                    ),
                  ),
                    buildWriteCommentRow(context),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  buildCommentItem(context, CommentsModel comment)
  {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              '${comment.image}',
            ),
            radius: 25.0,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: SocialCubit.get(context).isDark ? HexColor('3a3b3c') : HexColor('f0f2f5')),
                borderRadius: BorderRadius.circular(25.0),
                color: SocialCubit.get(context).isDark ? HexColor('3a3b3c') : HexColor('f0f2f5'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                          top : 10.0,
                          bottom: 3.0,
                        ),
                        child: Text(
                          '${comment.name}',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: SocialCubit.get(context).isDark ? Colors.white : Colors.black,
                              ),
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10.0,
                          bottom: 10.0,
                        ),
                        child: Text(
                          '${comment.text}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: SocialCubit.get(context).isDark ? Colors.white : Colors.black,
                          ),
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
    );
  }

  buildWriteCommentRow(context)
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Write your comment..',
                hintStyle: TextStyle(
                  color: SocialCubit.get(context).isDark ? Colors.white54 : Colors.black45,
                ),
                border: InputBorder.none,
              ),
              controller: commentController,
              maxLines: null,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          IconButton(
            onPressed: ()
            {
              SocialCubit.get(context).writeComment(
                postId: postId,
                dateTime: now.toString(),
                text: commentController.text,
              );
              commentController.clear();
            },
            icon: Transform.translate(
              offset: const Offset(10, 0),
              child: const Icon(
                IconBroken.Send,
                color: Colors.blue,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}