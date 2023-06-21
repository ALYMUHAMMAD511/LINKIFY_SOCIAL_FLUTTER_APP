import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import '../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget
{
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
                "Favorites",
            ),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) => buildFavoritesPostItem(SocialCubit.get(context).favoritesList[index], index, context),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: SocialCubit.get(context).favoritesList.length,
          ),
        );
      },
    );
  }
}