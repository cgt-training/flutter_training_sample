import 'package:flutter/material.dart';

// DB Operation
import 'package:flutter_training_app/db_operations/insert_tables.dart';
import 'package:flutter_training_app/response_model/comments_response.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Validator
import 'package:flutter_training_app/validators/textFieldValidators.dart';

// Summary: This class will provide the UI form for the detail of sync DB.
class SyncDBDetailUI{

    // DB_Operations
    InsertTables insertTable = new InsertTables();

    // Model
    CommentsResponse commentsModel = new CommentsResponse();
    PostsResponse postsModel = new PostsResponse();


    // Validator
    TextFieldValidators txtFieldValidators = new TextFieldValidators();


    // Summary: This function will execute when we submit form.
    submitForm(GlobalKey<FormState> _formKey, String table){
        print("submitForm()");
        if(_formKey.currentState.validate() && table == "posts"){
            _formKey.currentState.save();
            insertTable.insertPost(postsModel);
        }else if(_formKey.currentState.validate() && table == "comments"){
            _formKey.currentState.save();
            insertTable.insertComment(commentsModel);
        }
    }

    // Summary: This function will retrieve the data from database.
    retrieveData(String table){
        if(table == "posts"){
            insertTable.retrievePosts();
        }else if(table == "comments"){
            insertTable.retrieveComments();
        }

    }

    // Summary: Provide the UI for Posts Form
    Form sync_db_detail_posts(GlobalKey<FormState> _formKey, FocusNode postIdNode, FocusNode userIdNode, FocusNode titleNode, FocusNode bodyNode) {
        return Form(
            key: _formKey,
            child: Center(
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child:
                    Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Post Id'
                                ),
                                focusNode: postIdNode,
                                onSaved: (value) =>
                                postsModel.id = int.parse(value),
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'id')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter User Id'
                                ),
                                focusNode: userIdNode,
                                onSaved: (value) =>
                                postsModel.userId = int.parse(value),
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'id')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Post title'
                                ),
                                focusNode: titleNode,
                                onSaved: (value) => postsModel.title = value,
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'title')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Post description'
                                ),
                                focusNode: bodyNode,
                                onSaved: (value) => postsModel.body = value,
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'body')
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ButtonTheme(
                                    minWidth: 300,
                                    height: 30,
                                    child: FlatButton(
                                        color: Colors.pink[500],
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () =>
                                            this.submitForm(_formKey, "posts"),
                                        child: Text(
                                            "Sync With DB",
                                            style: TextStyle(fontSize: 20.0),
                                        ),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ButtonTheme(
                                    minWidth: 300,
                                    height: 30,
                                    child: FlatButton(
                                        color: Colors.pink[500],
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () => this.retrieveData("posts"),
                                        child: Text(
                                            "Retrieve from DB",
                                            style: TextStyle(fontSize: 20.0),
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                )
            ),
        );
    }

    // Summary: Provide the ui for comments form.
    Form sync_db_detail_comments(GlobalKey<FormState> _formKey, FocusNode postIdNode, FocusNode commentIdNode, FocusNode nameNode, FocusNode emailNode, FocusNode bodyNode) {

        return Form(
            key: _formKey,
            child: Center(
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child:
                    Column(
                        children: <Widget>[
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Comment Id'
                                ),
                                focusNode: commentIdNode,
                                onSaved: (value) =>
                                commentsModel.id = int.parse(value),
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'comment_id')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Post Id'
                                ),
                                focusNode: postIdNode,
                                onSaved: (value) =>
                                commentsModel.postId = int.parse(value),
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'post_id')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter User Name'
                                ),
                                focusNode: nameNode,
                                onSaved: (value) => commentsModel.name = value,
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'name')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter User Email'
                                ),
                                focusNode: emailNode,
                                onSaved: (value) => commentsModel.email = value,
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'email')
                            ),
                            TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Enter Comment'
                                ),
                                focusNode: bodyNode,
                                onSaved: (value) => commentsModel.body = value,
                                validator: (value) =>
                                    this.txtFieldValidators.validateFieldValue(
                                        value, 'comment')
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ButtonTheme(
                                    minWidth: 300,
                                    height: 30,
                                    child: FlatButton(
                                        color: Colors.pink[500],
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () =>
                                            this.submitForm(_formKey, "comments"),
                                        child: Text(
                                            "Sync With DB",
                                            style: TextStyle(fontSize: 20.0),
                                        ),
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ButtonTheme(
                                    minWidth: 300,
                                    height: 30,
                                    child: FlatButton(
                                        color: Colors.pink[500],
                                        textColor: Colors.white,
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        onPressed: () => this.retrieveData("comments"),
                                        child: Text(
                                            "Retrieve from DB",
                                            style: TextStyle(fontSize: 20.0),
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                )
            ),
        );
    }
}