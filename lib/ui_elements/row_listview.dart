import 'package:flutter/material.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

class RowListView{

    static Card postListRow(PostsResponse post, int index){

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
                        onTap: () => print(index),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 10),
                    )
                ],
            ),

        );
    }
}