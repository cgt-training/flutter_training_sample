import 'package:flutter/material.dart';

// Api Calling
import 'package:flutter_training_app/api_calling/posts.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';

// UI Elements
import 'package:flutter_training_app/ui_elements/row_listview.dart';

class PostsState extends State<Posts>{

    List<PostsResponse> postsResponseData;
    int lengthOfData;

    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        print("init State");
    }

    @override
    Widget build(BuildContext context) {
        print("build");
        // TODO: implement build
        return FutureBuilder(
            future: APICallPosts.getPosts(),
            builder: (BuildContext context, AsyncSnapshot<List<PostsResponse>> responseData){

                if(responseData.hasData){
                    List<PostsResponse> posts = responseData.data;
                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index){
                            return RowListView.postListRow(posts[index], index, context);
                        });
                }else{
                    return Center(child: CircularProgressIndicator());
                }
            },
        );

    }
}