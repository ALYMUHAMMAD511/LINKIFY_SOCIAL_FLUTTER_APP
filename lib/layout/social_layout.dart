import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/styles/icon_broken.dart';
import 'package:toast/toast.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);

    return BlocConsumer <SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions:
            [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:
            const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
            ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
          ),
        );
      }
    );
  }
}
