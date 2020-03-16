import 'package:flutter/material.dart';

// DB Operations
import 'package:flutter_training_app/db_operations/insert_tables.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';

// Screens
import 'package:flutter_training_app/screens/comments_detail.dart';

//Summary: Provide ui for row of comments list view.
class RowComments {

    // Summary: Will provide the UI for the row of comments list.
    static Card commentsListRow(BuildContext context, CommentsResponse data, index, InsertTables insertTables){

        return Card(
            child: Column(
                children: <Widget>[
                    Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .8)),
                        child: ListTile(
                            leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    Icon(
                                        Icons.insert_comment
                                    )
                                ],
                            ),
                            title: Text(
                                data.email,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                data.body,
                                style: TextStyle(color: Colors.white),
                            ),
                            trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.keyboard_arrow_right),
                                        onPressed:()=> print("onPressed ICON button"),
                                    )
                                ],
                            ),
                            onTap: (){
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context){
                                            return CommentsDetail(data);
                                        }
                                    )
                                );
                            },
                        ),
                    )
                ],
            ),

        );
    }

}