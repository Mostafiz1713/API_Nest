class Details {
  int userId;
  int id;
  String title;
  String body;
  String str_userId;
  String str_id;

  Details.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    str_userId = userId.toString() ;
    str_id = id.toString() ;
  }

}