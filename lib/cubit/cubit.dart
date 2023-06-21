import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/comments_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import '../models/post_model.dart';
import '../modules/login/login_screen.dart';
import '../modules/new post/new_post_screen.dart';
import '../modules/profile/profile_screen.dart';
import '../shared/components/components.dart';
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
    NewPostScreen(),
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
  File? postImage;
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
      emit(SocialUploadProfileImageErrorState());
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
      emit(SocialUploadCoverImageErrorState());
    });
  }


  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? image,
  })
  {
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

  Future<void> getPostImage () async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else
    {
      if (kDebugMode)
      {
        print('No Image Selected');
      }
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  })
  {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        if (kDebugMode)
        {
          print(value);
        }
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  })
  {
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
        .then((value)
    {
      emit(SocialCreatePostSuccessState());
    }).catchError((error)
    {
      SocialCreatePostErrorState();
    });
  }

  List <PostModel> posts = [];
  List <String> postsId = [];
  List <int> likes = [];

  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      for (var element in value.docs)
      {
        element.reference
            .collection('likes')
            .get()
            .then((value)
        {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
            .catchError((error) {});
      }
      emit(SocialGetPostsSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetPostsErrorState(error.toString()));
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
      'like' : true,
    })
        .then((value)
    {
      emit(SocialLikePostSuccessState());
    })
        .catchError((error)
    {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  File? commentImage;
  Future<void> getCommentImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      commentImage = File(pickedFile.path);
      if (kDebugMode)
      {
        print(pickedFile.path);
      }
      emit(SocialCommentImagePickedSuccessState());
    }
    else
    {
      if (kDebugMode)
      {
        print('No Image Selected');
      }
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void uploadCommentImage({
    required String uId,
    required String text,
    String? postId,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("comments/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        createComment(
          uId: uId,
          text: text,
          commentImage: value,
          postId: postId!,
        );
        emit(SocialUploadCommentImageSuccessState());
      }).catchError((error)
      {
        emit(SocialUploadCommentImageErrorState());
      });
    }).catchError((error)
    {
      emit(SocialUploadCommentImageErrorState());
    });
  }

  void createComment({
    required String uId,
    required String text,
    String? commentImage,
    String? postId,
  })
  {
    emit(SocialCreateCommentLoadingState());
    CommentsModel commentModel = CommentsModel(
      name: userModel!.name,
      text: text,
      image: userModel!.image,
      uId: userModel!.uId,
      commentImage: commentImage,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .doc(uId)
        .collection("comments")
        .doc(userModel!.uId)
        .set(commentModel.toMap())
        .then((value)
    {
      emit(SocialCreateCommentSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCreateCommentErrorState(error.toString()));
    });
  }

  List<CommentsModel> postsComments = [];
  List<String> postsIdComment = [];
  List<int> comments = [];

  void getComments()
  {
    emit(SocialGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)
    {
      for (var element in value.docs)
      {
        element.reference
            .collection('comments')
            .get()
            .then((value)
        {
          comments.add(value.docs.length);
          postsIdComment.add(element.id);
          postsComments.add(CommentsModel.fromJson(element.data()));
        })
            .catchError((error) {});
      }
      emit(SocialGetCommentsSuccessState());
    })
        .catchError((error)
    {
      emit(SocialGetCommentsErrorState(error.toString()));
    });
  }

  List <UserModel> users = [];

  void getAllUsers()
  {
    emit(SocialGetPostsLoadingState());
    if (users.isEmpty)
    {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
        for (var element in value.docs) {
          users.add(UserModel.fromJson(element.data()));
        }
        emit(SocialGetAllUsersSuccessState());
      })
          .catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  List<int> userPosts = [];
  var postLength;
  var PostUId;

  void getUserPostsLength()
  {
    emit(SocialGetMessageLoginState());
    userPosts = [];
    var userPostsCount = FirebaseFirestore.instance.collection('posts');
    userPostsCount.where('uId', isEqualTo: uId).get()
        .then((value)
    {
      for (var element in value.docs)
      {
        userPosts.add(element.data().length);
      }
      postLength = userPosts.length;
      emit(SocialGetUserPostsLengthSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetUserPostsLengthErrorState());
    });
  }

  List<dynamic> followersLength = [];
  var followersCount;

  void getUserFollowersLength()
  {
    emit(SocialGetUserFollowersLengthLoadingState());
    followersLength = [];
    var userFollowersCount = FirebaseFirestore.instance.collection('users');
    userFollowersCount.doc(uId).collection("chats").get().then((value) {
      followersCount = value.docs.length;
      if (kDebugMode)
      {
        print(followersCount);
      }

      emit(SocialGetUserFollowersLengthSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetUserFollowersLengthErrorState());
    });
  }

  void addToFavorites({
    String? name,
    String? uId,
    String? image,
    String? dateTime,
    String? text,
    String? postImage,
    String? postsId,
  }) {
    emit(SocialAddToFavoritesLoadingState());
    PostModel postModel = PostModel(
        dateTime: dateTime,
        uId: uId,
        image: image,
        name: name,
        postImage: postImage ?? '',
        text: text ?? '');
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("favoritesList")
        .add(postModel.toMap())
        .then((value)
    {
      emit(SocialAddToFavoritesSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialAddToFavoritesErrorState());
    });
  }

  List<PostModel> favoritesList = [];

  void getFavoritesList()
  {
    favoritesList = [];
    emit(SocialGetFavoritesLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("favoritesList")
        .get()
        .then((value)
    {
      for (var element in value.docs)
      {
        favoritesList.add(PostModel.fromJson(element.data()));
      }
      if (kDebugMode)
      {
        print(favoritesList.length);
      }
      emit(SocialGetFavoritesSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetFavoritesErrorState());
    });
  }

  void removeFromFavorites(postId)
  {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("favoritesList")
        .doc(postId)
        .delete()
        .then((value)
    {
      emit(SocialRemoveFromFavoritesSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error);
      }
      emit(SocialRemoveFromFavoritesErrorState());
    });
  }

  void addToWatchLater({
    String? name,
    String? uId,
    String? image,
    String? dateTime,
    String? text,
    String? postImage,
    String? postsId,
  })
  {
    emit(SocialAddToWatchLaterLoadingState());
    PostModel postModel = PostModel(
        dateTime: dateTime,
        uId: uId,
        image: image,
        name: name,
        postImage: postImage ?? '',
        text: text ?? '');
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("watchLaterList")
        .add(postModel.toMap())
        .then((value)
    {
      emit(SocialAddToWatchLaterSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialAddToWatchLaterErrorState());
    });
  }

  List<PostModel> watchLaterList = [];
  void getWatchLaterList()
  {
    watchLaterList = [];
    emit(SocialGetWatchLaterLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("watchLaterList")
        .get()
        .then((value)
    {
      for (var element in value.docs)
      {
        watchLaterList.add(PostModel.fromJson(element.data()));
      }
      if (kDebugMode)
      {
        print(favoritesList.length);
      }
      emit(SocialGetWatchLaterSuccessState());
    })
        .catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialGetWatchLaterErrorState());
    });
  }

  void signOut(context)
  {
    FirebaseAuth.instance.signOut().
    then((value)
    {
      navigateTo(context, LoginScreen());
      emit(SocialUserSignOutSuccessState());
    }).catchError((error)
    {
      if (kDebugMode)
      {
        print(error.toString());
      }
      emit(SocialUserSignOutErrorState());
    });
  }

  late bool isDark = false;

  void changeThemeMode({bool? fromShared})
  {
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