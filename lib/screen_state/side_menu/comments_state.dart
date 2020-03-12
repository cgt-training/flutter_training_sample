import 'package:flutter/material.dart';

// API Call
import 'package:flutter_training_app/api_calling/api_call_comments.dart';
import 'package:flutter_training_app/db_operations/insert_tables.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';

// Screens
import 'package:flutter_training_app/screens/side_menu_screens/comments.dart';
import 'package:flutter_training_app/ui_elements/row_comments.dart';

// Summary: Provide the state for comments class.
class CommentsState extends State<Comments>{

    InsertTables insertTables = new InsertTables();

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return FutureBuilder(

            future: APICallComments.getCommentsFromAPI(),
            builder: (BuildContext context, AsyncSnapshot<List<CommentsResponse>> responseData){
                if(responseData.hasData){
                    List<CommentsResponse> listData = responseData.data;
                    return MediaQuery.removePadding(
                        context: context,
                        child: ListView.builder(
                                    itemCount: listData.length,
                                    itemBuilder: (context, index){
                                            return RowComments.commentsListRow(context, listData[index], index, insertTables);
                                    }),
                        removeTop: true,
                    );
                }else{

                    return Center(
                        child: CircularProgressIndicator()
                    );
                }
            },
        );

    }

}