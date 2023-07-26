class CommentsModel {
  String? name;
  String? uId;
  String? image;
  String? commentText;
  String? commentImage;
  String? postId;

  CommentsModel(
      {
        this.name,
        this.uId,
        this.image,
        this.commentText,
        this.commentImage,
        this.postId
      });

  CommentsModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    commentText = json['commentText'];
    commentImage = json['commentImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'name': name,
        'uId': uId,
        'image': image,
        'commentText': commentText,
        'commentImage': commentImage,
        'postId': postId
    };
  }
}