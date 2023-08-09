class CommentsModel
{
  String? name;
  String? dateTime;
  String? image;
  String? text;
  String? uId;

  CommentsModel({
    this.uId,
    this.text,
    this.name,
    this.dateTime,
    this.image,
  });

  CommentsModel.fromJson(Map<String, dynamic>json)
  {
    text=json['text'];
    name=json['name'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    image=json['image'];
  }
  Map<String,dynamic>toMap()
  {
    return
      {
        'name':name,
        'dateTime':dateTime,
        'text':text,
        'uId':uId,
        'image':image,
    };
  }
}