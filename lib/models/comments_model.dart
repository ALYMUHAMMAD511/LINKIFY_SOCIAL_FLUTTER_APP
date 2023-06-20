class CommentsModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? commentImage;
  String? postId;

  CommentsModel(
      {
        this.name,
        this.uId,
        this.image,
        this.text,
        this.commentImage,
        this.postId
      });

  CommentsModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    text = json['text'];
    commentImage = json['commentImage'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'name': name,
        'uId': uId,
        'image': image,
        'textComment': text,
        'imageComment': commentImage,
        'postId': postId
    };
  }
}