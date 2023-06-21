import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/favorites/favorites_screen.dart';
import 'package:social_app/modules/watch%20later/watch_later_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                const SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: (() {
                    navigateTo(context, const FavoritesScreen());
                  }),
                  child: Card(
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
                              "https://img.freepik.com/free-vector/background-with-white-feathers-with-gold-glitter-confetti-empty-space-vector-poster-with-realistic-illustration-flying-golden-colored-bird-angel-quills-sparkles-ribbons_107791-9934.jpg?w=900"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(IconBroken.Heart),
                              const SizedBox(width: 5.0),
                              const Text(
                                "Favorites",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${SocialCubit.get(context).favoritesList.length}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
                    navigateTo(context, const WatchLaterScreen());
                  }),
                  child: Card(
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
                              "https://img.freepik.com/free-vector/early-morning-cartoon-nature-landscape-sunrise_107791-10161.jpg?t=st=1645370428~exp=1645371028~hmac=657740f90dc7aa5221be339ebccd4bb10d433641f923f198fbf1c73f065e3967&w=900"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Icon(IconBroken.Time_Circle),
                              const SizedBox(
                                  width: 5.0,
                              ),
                              const Text(
                                "Watch Later",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "${SocialCubit.get(context).watchLaterList.length}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: defaultButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).signOut(context);
                      },
                      text: "Log Out"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}