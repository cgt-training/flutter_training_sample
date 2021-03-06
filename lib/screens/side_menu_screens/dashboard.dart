import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';


// DB Operation
import 'package:flutter_training_app/db_operations/insert_tables.dart';

// Screens
import 'package:flutter_training_app/screens/screen_props/login_props.dart';
import 'package:flutter_training_app/screens/sync_db_detail.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Models
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Summary: Class will provide the link to update the database with network.
class Dashboard extends StatelessWidget {

    InsertTables insertTables = new InsertTables();

    // Summary: Provide the cards UI for dashboard.
    postsCardUI(LoginProps props, String table, BuildContext context){

        return Card(
            child: Container(
                decoration: BoxDecoration(color: Colors.black12),
                height: 150,
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            'Sync '+ table +' with DB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16
                            ),
                        ),
                        SizedBox(
                            height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * .3,
                            child: RaisedButton(
                                color: Colors.grey[400],
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Column(
                                    children: <Widget>[
                                        Icon(Icons.dashboard),
                                        Text(
                                            'Sync '+table,
                                            style: TextStyle(
                                                color: Colors.grey[700]
                                            ),
                                        )
                                    ],
                                ),
                                onPressed: (){
                                    print("Button pressed for "+table);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder:(context){
                                                return SyncDBDetail(table);
                                            }
                                        )

                                    );
                                }

                            )
                        )

                    ],
                ),
            ),
        );
    }

    // Summary: Used to store data in database.
    onInitialBuildMethod(LoginProps props){
        // Summary: Will insert the data in database.
        if(props.postsList.length > 0){
            insertTables.insertMultiplePost(props.postsList);
            insertTables.insertMultipleComments(props.commentsList);
        }
    }

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store) {

                return LoginProps.mapStateToProps(store);
            },
            onInitialBuild: (props){
                this.onInitialBuildMethod(props);
            },
            builder: (BuildContext context, props) {

                return Center(
                    child: Scaffold(
                        appBar: AppBar(
                            title: Text('Dashboard'),
                        ),
                        body: Scrollbar(
                            child: SingleChildScrollView(
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                        children: <Widget>[

                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .15,
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                    postsCardUI(props, 'Posts', context),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * .1
                                                    ),
                                                    postsCardUI(props, 'Comments', context)
                                                ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .05,
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                    postsCardUI(props, 'Albums', context),
                                                    SizedBox(
                                                        width: MediaQuery.of(context).size.width * .1
                                                    ),
                                                    postsCardUI(props, 'Photos', context)
                                                ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context).size.height * .05,
                                            ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                    postsCardUI(props, 'ToDos', context),
                                                ],
                                            ),
                                        ],
                                    ),
                                )
                            ),
                        )
                    )
                );
            });
    }
}