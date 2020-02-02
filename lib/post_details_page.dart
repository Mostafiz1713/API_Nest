import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_details.dart';

class PageDetails extends StatefulWidget {
  @override
  _PageDetailsState createState() => _PageDetailsState();
}

class _PageDetailsState extends State<PageDetails> {
  List<Details> _plist = [];
  var loading = false;
  
  Future<Null> _fetchData() async{
    setState(() {
      loading = true;
    });
    
    final res = await http.get("https://jsonplaceholder.typicode.com/posts/2");
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      setState(() {
        for (Map j in data)
          _plist.add(Details.fromJson(j));
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
        title: Center(child: Text("Page Details")),
        elevation: 0.0,
      ),
      body: Container(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: _plist.length,
          itemBuilder: (context, j) {
            final y = _plist[j];
            return Container(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Card(
                  color: Colors.lightBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("userId: ",
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      Text(y.str_userId),
                      Text("id: ",
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      Text(y.str_id),
                      Text("Title: ",
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      Text(y.title),
                      Text("Body: ",
                          style:
                          TextStyle(fontWeight: FontWeight.bold)),
                      Text(y.body),
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
