import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
            title: Text("Post Detail"),
            backgroundColor: Colors.grey[500],
        ),
        body: Center(
            child: Text("Post_Detail Page")
        ),
    );
  }

}