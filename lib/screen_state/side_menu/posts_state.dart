import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Api Calling
import 'package:flutter_training_app/api_calling/posts.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';

class PostsState extends State<Posts>{

    List<PostsResponse> postsResponseData;
    int lengthOfData;

    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        print("initState()");
        APICallPosts.getPosts().then((List<PostsResponse> response)=>{
            print(response)
//            postsResponseData = response
        });
    }

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: lengthOfData,
        itemBuilder: (context, index){
            return ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(postsResponseData[index].title),
                trailing: Icon(Icons.keyboard_arrow_right),
            );
    });
  }
}