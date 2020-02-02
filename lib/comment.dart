class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;
  String str_postId;
  String str_id;

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
    str_postId = postId.toString() ;
    str_id = id.toString() ;
  }
}
