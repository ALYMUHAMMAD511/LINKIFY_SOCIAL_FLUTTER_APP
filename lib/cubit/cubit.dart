import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/comments_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import '../models/post_model.dart';
import '../modules/login/login_screen.dart';
import '../modules/new post/new_post_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (kDebugMode)
      {
        print(value.data());
      }
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Profile',
  ];

  void changeBottomNav(int index)
  {
    if (index == 1)
    {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  File? coverImage;
  File? postImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      if (kDebugMode) {
        print(pickedFile.path);
      }
      emit(SocialProfileImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No Image Selected');
      }
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No Image Selected');
      }
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        updateUser(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  }) {
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
        .then((value) {
      getUserData();
    }).catchError((error) {
      SocialUserUpdateErrorState();
    });
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No Image Selected');
      }
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        if (kDebugMode) {
          print(value);
        }
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      uId: userModel!.uId,
      name: userModel!.name,
      image: userModel!.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      SocialCreatePostErrorState();
    });
  }

  List<PostModel>? posts = [];
  List<String>? postsId = [];
  List<int>? likes = [];

  void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime')
        .get()
        .asStream().listen((value)
    {
      for (var element in value.docs)
      {
      element.reference.collection('likes').get().then((value)
      {
        likes!.add(value.docs.length);
        postsId!.add(element.id);
        posts!.add(PostModel.fromJson(element.data()));
      }).catchError((error)
      {
        emit(SocialGetPostsErrorState(error.toString()));
        if (kDebugMode)
        {
          print(error.toString());
        }
      });
    }
    emit(SocialGetPostsSuccessState());
    });
  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value)
    {
      emit(SocialLikePostSuccessState());
    }).catchError((error)
    {
      emit(SocialLikePostErrorState(error.toString()));
      if (kDebugMode)
      {
        print(error.toString());
      }
    });
  }

  List<UserModel>? allUsers = [];

  void getAllUsers()
  {
    emit(SocialGetPostsLoadingState());
    if (allUsers!.isEmpty)
    {
      FirebaseFirestore.instance.collection('users').get().then((value)
      {
        for (var element in value.docs)
        {
          if(element.data()['uId'] != userModel!.uId)
          {
            allUsers!.add(UserModel.fromJson(element.data()));
          }
        }
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error)
      {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  CommentsModel? commentModel;

  void writeComment({
    required String postId,
    required String dateTime,
    required String text,
  }) {
    commentModel = CommentsModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel!.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessState());
    }).catchError((error)
    {
      emit(SocialCreateCommentErrorState(error));
    });
  }

  List<CommentsModel> comments = [];

  void getComments({
    required String postId,
  })
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      comments = [];
      for (var element in event.docs)
      {
        comments.add(CommentsModel.fromJson(element.data()));
      }
      emit(SocialGetCommentsSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  })
  {
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );
    // Setting my chat messages
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    // Setting receiver's chat messages
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverId})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];

      for (var element in event.docs)
      {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }

  dynamic logout(context) async
  {
    await CacheHelper.removeData(
      key: 'uId',
    ).then((value)
    {
      if (value)
      {
        navigateAndFinish(context, LoginScreen());
        SocialCubit.get(context).currentIndex = 0;
      }
    });
  }

  late bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}