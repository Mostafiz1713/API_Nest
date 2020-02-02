import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'comment.dart';
import 'post_details_page.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<Comment> _clist = [];
  var loading = false;

  Future<Null> _fetchData() async {
    setState(() {
      loading = true;
    });

    final res =
        await http.get("https://jsonplaceholder.typicode.com/posts/2/comments");
    if (res.statusCode == 200) {
      final cdata = jsonDecode(res.body);
      setState(() {
        for (Map k in cdata) _clist.add(Comment.fromJson(k));
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Comments")),
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _clist.length,
                itemBuilder: (context, k) {
                  final z = _clist[k];
                  return Container(
                    padding: EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Card(
                        color: Colors.lightBlue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("userId: ",
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                            Text(z.str_postId),
                            Text("id: ",
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                            Text(z.str_id),
                            Text("Title: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(z.name),
                            Text("Body: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(z.body),
                            Text("Email: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(z.email)
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageDetails()));
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
