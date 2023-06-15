import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';

import '../shared/network/local/cache_helper.dart';

class SocialCubit extends Cubit <SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (kDebugMode) {
        print(value.data());
      }
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List <Widget> screens =
  [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List <String> titles =
  [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if (index == 2)
      {
        emit(SocialNewPostState());
      }
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }
  }

  late bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    }
    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}