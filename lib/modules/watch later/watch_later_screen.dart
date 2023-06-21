import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';


class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Watch Later"),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) =>
                buildPostItem(
                    SocialCubit
                        .get(context)
                        .watchLaterList[index], index, context),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: SocialCubit
                .get(context)
                .watchLaterList
                .length,
          ),
        );
      },
    );
  }
}