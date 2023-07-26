import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/favorites/favorites_screen.dart';
import 'package:social_app/modules/saved%20posts/saved_posts_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class UsersScreen extends StatelessWidget
{
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                InkWell(
                  onTap: (() {
                    navigateTo(context, const FavoritesScreen());
                  }),
                  child: Card(
                    color: SocialCubit
                        .get(context)
                        .isDark ? HexColor('333739') : Colors.white,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          width: double.infinity,
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/vintage-black-white-flower-pattern-illustration_53876-96941.jpg?w=1380&t=st=1687380311~exp=1687380911~hmac=ba7d6d202fcc4e8120ab84e18e79fa9ef325a50d2b6d8ad66e75269b02925779"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                color: SocialCubit
                                    .get(context)
                                    .isDark ? Colors.white : Colors.black,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: SocialCubit
                                      .get(context)
                                      .isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${SocialCubit
                                    .get(context)
                                    .favoritesList
                                    .length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: SocialCubit
                                      .get(context)
                                      .isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: (() {
                    navigateTo(context, const SavedPostsScreen());
                  }),
                  child: Card(
                    color: SocialCubit
                        .get(context)
                        .isDark ? HexColor('333739') : Colors.white,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Image(
                          width: double.infinity,
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/white-alarm-clock-sticker-with-inscription-late-blue-background_169016-33777.jpg?w=900&t=st=1687380385~exp=1687380985~hmac=279b585bfa990e9ef3fafca353370aee4ee3d47435b36a80a560c678ea600e83"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Time_Circle,
                                color: SocialCubit
                                    .get(context)
                                    .isDark ? Colors.white : Colors.black,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Saved Posts",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: SocialCubit
                                      .get(context)
                                      .isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${SocialCubit
                                    .get(context)
                                    .savedPosts
                                    .length}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: SocialCubit
                                      .get(context)
                                      .isDark ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 10),
                  child: defaultButton(
                      onPressed: () {
                        SocialCubit.get(context).logout(context);
                      },
                      text: "Log Out"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}