import 'package:flutter/material.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/post_detail.dart';

class RowListView{

    static Card postListRow(PostsResponse post, int index, BuildContext context){

        return Card(
            child: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(top: 10),
                    ),
                    ListTile(
                        leading: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Icon( Icons.insert_comment )
                        ),
                        title: Text(post.title),
                        subtitle: Text(post.body),
                        trailing: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Icon(Icons.keyboard_arrow_right)
                        ),
                        onTap: () {
                            print(index);
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context){
                                        return PostDetail();
                                    }
                                )
                            );
                        },
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                    )
                ],
            ),

        );
    }
}