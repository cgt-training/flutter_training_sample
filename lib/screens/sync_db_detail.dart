import 'package:flutter/material.dart';

// DB Operations
import 'package:flutter_training_app/db_operations/create_tables.dart';
import 'package:flutter_training_app/db_operations/insert_tables.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

// Summary: class will triggered when we try to sync data from dashboard.
class SyncDBDetail extends StatelessWidget {

    String tableName;
    final _formKey = GlobalKey<FormState>();

    // DB_Operations
    InsertTables insertTable = new InsertTables();

    // Form nodes
    FocusNode postIdNode = new FocusNode();
    FocusNode userIdNode = new FocusNode();
    FocusNode titleNode = new FocusNode();
    FocusNode bodyNode = new FocusNode();

    // Models
    PostsResponse postsModel = new PostsResponse();

    // Validators
    TextFieldValidators txtFieldValidators = new TextFieldValidators();

    // Will Create the table in database.
    SyncDBDetail(String name){

        this.tableName = name;
        // Summary: Will create the table if not created yet.
        Future<dynamic> response = CreateTables.createTableStatement(this.tableName);
    }

    // Summary: This function will execute when we submit form.
    submitForm(){
        print("submitForm()");
        if(_formKey.currentState.validate()){
            _formKey.currentState.save();
            insertTable.insertPost(postsModel);
        }
    }

    // Summary: This function will retrieve the data from database.
    retrieveData(){
        insertTable.retrievePosts();
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.grey[700],
                title: Text("Sync Data with DB"),
            ),
            body:
            Form(
                key: _formKey,
                    child: Center(
                        child:Container(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Enter Post Id'
                                        ),
                                        focusNode: postIdNode,
                                        onSaved: (value) => postsModel.id = int.parse(value),
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'id')
                                    ),
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Enter User Id'
                                        ),
                                        focusNode: userIdNode,
                                        onSaved: (value) => postsModel.userId = int.parse(value),
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'id')
                                    ),
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Enter Post title'
                                        ),
                                        focusNode: titleNode,
                                        onSaved: (value) => postsModel.title = value,
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'title')
                                    ),
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Enter Post description'
                                        ),
                                        focusNode: bodyNode,
                                        onSaved: (value) => postsModel.body = value,
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'body')
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: ButtonTheme(
                                            minWidth: 300,
                                            height:30,
                                            child: FlatButton(
                                                color: Colors.pink[500],
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                onPressed: ()=> this.submitForm(),
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
                                            height:30,
                                            child: FlatButton(
                                                color: Colors.pink[500],
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                onPressed: ()=> this.retrieveData(),
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
             )
        );
    }
}
