abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates
{
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates
{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialGetPostsLoadingState extends SocialStates {}

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates
{
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates
{
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialCreateCommentLoadingState extends SocialStates {}

class SocialCreateCommentSuccessState extends SocialStates {}

class SocialCreateCommentErrorState extends SocialStates
{
  final String error;
  SocialCreateCommentErrorState(this.error);
}

class SocialCommentImagePickedSuccessState extends SocialStates {}

class SocialCommentImagePickedErrorState extends SocialStates {}

class SocialUploadCommentImageSuccessState extends SocialStates {}

class SocialUploadCommentImageErrorState extends SocialStates {}

class SocialGetCommentsLoadingState extends SocialStates {}

class SocialGetCommentsSuccessState extends SocialStates {}

class SocialGetCommentsErrorState extends SocialStates
{
  final String error;
  SocialGetCommentsErrorState(this.error);
}

class SocialAddToFavoritesLoadingState extends SocialStates {}

class SocialAddToFavoritesSuccessState extends SocialStates {}

class SocialAddToFavoritesErrorState extends SocialStates {}

class SocialGetFavoritesLoadingState extends SocialStates {}

class SocialGetFavoritesSuccessState extends SocialStates {}

class SocialGetFavoritesErrorState extends SocialStates {}

class SocialRemoveFromFavoritesLoadingState extends SocialStates {}

class SocialRemoveFromFavoritesSuccessState extends SocialStates {}

class SocialRemoveFromFavoritesErrorState extends SocialStates {}

class SocialSavePostLoadingState extends SocialStates {}

class SocialSavePostSuccessState extends SocialStates {}

class SocialSavePostErrorState extends SocialStates {}

class SocialGetSavedPostsLoadingState extends SocialStates {}

class SocialGetSavedPostsSuccessState extends SocialStates {}

class SocialGetSavedPostsErrorState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessagesSuccessState extends SocialStates {}

class SocialUserLogoutSuccessState extends SocialStates {}

class SocialUserLogoutErrorState extends SocialStates {}

class AppChangeThemeModeState extends SocialStates {}