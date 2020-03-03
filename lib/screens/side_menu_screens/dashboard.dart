import 'package:flutter/material.dart';
import 'package:flutter_training_app/response_model/login/login_response_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Models
import 'package:flutter_training_app/response_model/loginResponse.dart';

class Dashboard extends StatelessWidget {
    LoginStateGlobal _loginAPIResponseObject;

    @override
    Widget build(BuildContext context) {
        return StoreConnector(
            converter: (Store<AppState> store) {
                this._loginAPIResponseObject = store.state.loginStateGlobal;
            },
            builder: (BuildContext context, vm) {
                return Center(
                    child: Column(
                        children: <Widget>[
                            Text("this._loginAPIResponseObject.email"),
                            Text("this._loginAPIResponseObject.message"),
                            Text("this._loginAPIResponseObject.token")
                        ],
                    ),
                );
            });
    }
}