import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Db Operations
import 'package:flutter_training_app/db_operations/insert_tables.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/post_detail.dart';

// Summary: Returns the UI for row of posts list view.
class RowListView{

    static Card postListRow(PostsResponse post, int index, BuildContext context, InsertTables insertTables){

        insertTables.insertPost(post);

        return Card(
            child: Column(
                children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                            leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Icon( Icons.insert_comment )
                                ],

                            ),
                            title: Text(
                                post.title,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                post.body,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                            ),
                            trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Icon(Icons.keyboard_arrow_right)
                                ],

                            ),
                            onTap: () {

                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context){
                                            return PostDetail(post);
                                        }
                                    )
                                );
                            },
                        ),
                    ),

                ],
            ),

        );
    }
}