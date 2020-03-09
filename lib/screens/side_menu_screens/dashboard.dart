import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_training_app/screens/screen_props/login_props.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Models
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Summary: Class will provide the link to update the database with network.
class Dashboard extends StatelessWidget {

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
                                onPressed: ()=> print("Button pressed for "+table),
                            )
                        )

                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store) {
//                this._loginAPIResponseObject = store.state.loginAPIResponse;
                return LoginProps.mapStateToProps(store);
            },
            builder: (BuildContext context, props) {
                return Center(
                    child: Scrollbar(
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


                );
            });
    }
}