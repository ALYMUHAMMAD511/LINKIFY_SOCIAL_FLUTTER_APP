class PostModel
{
  String? name;
  String? uId;
  String? text;
  String? image;
  String? dateTime;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.text,
    this.image,
    this.dateTime,
    this.postImage,
  });

  PostModel.fromJson(Map <String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    text = json['text'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
  }

  Map <String, dynamic> toMap()
  {
    return
      {
        'name' : name,
        'uId' : uId,
        'text' : text,
        'image' : image,
        'dateTime' : dateTime,
        'postImage' : postImage,
      };
  }
}