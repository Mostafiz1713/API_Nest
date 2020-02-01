class UserInfo {
  int userId;
  int id;
  String title;
  String body;

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}