import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// DB Operations
import 'package:flutter_training_app/db_operations/create_tables.dart';
import 'package:flutter_training_app/db_operations/insert_tables.dart';
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';
import 'package:flutter_training_app/screens/screen_props/login_props.dart';
import 'package:flutter_training_app/ui_elements/sync_db_detail_ui.dart';

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
    FocusNode commentIdNode = new FocusNode();

    // Models
    PostsResponse postsModel = new PostsResponse();

    // UI Elements
    SyncDBDetailUI syncDBDetailUI = new SyncDBDetailUI();

    // Validators
    TextFieldValidators txtFieldValidators = new TextFieldValidators();

    // Will Create the table in database.
    SyncDBDetail(String name){

        this.tableName = name;
    }


    // Summary: This function will provide the ui on based on condition.
    uiForTheBuilder(){

        if(this.tableName == "Posts"){
            return syncDBDetailUI.sync_db_detail_posts(_formKey, postIdNode, userIdNode, titleNode, bodyNode);
        } else if(this.tableName == "Comments"){
            return syncDBDetailUI.sync_db_detail_comments(_formKey, postIdNode, commentIdNode, userIdNode, titleNode, bodyNode);
        }
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store){

                return LoginProps.mapStateToProps(store);
            },
            builder: (BuildContext context, props){

                return Scaffold(
                    appBar: AppBar(
                        backgroundColor: Colors.grey[700],
                        title: Text("Sync Data with DB"),
                    ),
                    body: Scrollbar(
                        child: SingleChildScrollView(
                            child: uiForTheBuilder(),
                        ),
                    )
                );
            },
        );


    }
}
