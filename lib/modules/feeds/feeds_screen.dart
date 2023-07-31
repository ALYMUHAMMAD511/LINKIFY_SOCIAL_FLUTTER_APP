import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children:
                  [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children:
                        [
                          const Image(
                            image: NetworkImage(
                                'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Communicate with Friends',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) =>
                          buildPostItem(SocialCubit
                              .get(context)
                              .posts[index], context, index),
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        height: 10.0,
                      ),
                      itemCount: SocialCubit
                          .get(context)
                          .posts
                          .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}