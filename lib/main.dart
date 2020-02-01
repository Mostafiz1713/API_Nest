import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';
import 'comment_page.dart';
import 'post.dart';
import 'post_details_page.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  AppState createState() => new AppState();
}

class AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 2,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset(
        'assets/loader.gif',
        color: Colors.black,
      ),
      backgroundColor: Colors.lightBlue,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
    );
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  List<UserInfo> _list = [];
  var loading = false;

  Future<Null> _fetchData() async {
    setState(() {
      loading = true;
    });

    final response =
        await http.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(UserInfo.fromJson(i));
        }
        print(_list[1]);
        loading = false;
      });
    } else {
      throw Exception('Failed to load post');
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
        title: Center(child: Text("Post")),
        elevation: 0.0,
      ),
      body: Container(
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, i) {
                    final x = _list[i];
                    return Container(
                      padding: EdgeInsets.all(5.0),
                      child: GestureDetector(
                        child: Card(
                          color: Colors.lightBlue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //Text(x.userId),
//                          Text(x.id),
                              Text("Title: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(x.title),
                              Text("Body: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(x.body),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentPage()));
                        },
                      ),
                    );
                  },
                )),
    );
  }
}
