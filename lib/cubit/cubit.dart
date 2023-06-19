import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import '../modules/profile/profile_screen.dart';
import '../shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


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
    const NewPostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List <String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Profile',
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

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getProfileImage () async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      if (kDebugMode)
      {
        print(pickedFile.path);
      }
      emit(SocialProfileImagePickedSuccessState());
    }
    else
    {
      if (kDebugMode)
      {
        print('No Image Selected');
      }
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage () async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else
    {
      if (kDebugMode)
      {
        print('No Image Selected');
      }
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,})
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        if (kDebugMode)
        {
          print(value);
        }
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadProfileImageSuccessState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,})
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        if (kDebugMode)
        {
          print(value);
        }
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageSuccessState());
    });
  }


  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }){
    UserModel model = UserModel(
      email: userModel!.email,
      uId: uId,
      name: name,
      bio: bio,
      phone: phone,
      isEmailVerified: false,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value)
    {
      getUserData();
    }).catchError((error)
    {
      SocialUserUpdateErrorState();
    });
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
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(AppChangeThemeModeState());
      });
    }
  }
}