import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import '../../shared/components/components.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatelessWidget {
  var textController = TextEditingController();
  final String uIdIndex;

  CommentsScreen({super.key, required this.uIdIndex});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, states) {},
      builder: (context, states) {
        var cubit = SocialCubit.get(context);
        return Scaffold
          (
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: ()
                {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildCommentItem(context, SocialCubit.get(context).commentsModel[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8.0,
                          ),
                          itemCount: cubit.commentsModel.length,
                        ),
                      ),
                    ),
                    TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'Write a Comment ...',
                        hintStyle: TextStyle(
                          color: cubit.isDark ? Colors.white54 : Colors.black45,
                          fontSize: 14.0,
                        ),
                        prefixIcon: InkWell(
                          child: const Icon(
                              Icons.camera_alt,
                            color: Colors.grey,
                          ),
                          onTap: ()
                          {
                            cubit.getCommentImage();
                          },
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (cubit.commentImage == null)
                            {
                              cubit.createComment(
                                commentText: textController.text,
                                postId: uIdIndex,
                                commentUId: uIdIndex,
                              );
                            }
                            else
                            {
                              cubit.uploadCommentImage(
                                text: textController.text,
                                uId: uIdIndex,
                                postId: uIdIndex,
                              );
                            }
                            textController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.black,
                          height: 1,
                      ),
                    ),
                  ],
                )
            )
        );
      },
    );
  }
}