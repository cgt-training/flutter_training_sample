import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
//Models
import 'package:flutter_training_app/models/redux/redux_models.dart';

// Reducers
import 'package:flutter_training_app/reducers/app_reducer.dart';

// Reponse Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Screens
import 'package:flutter_training_app/screens/login.dart';
import 'package:flutter_training_app/screens/registration.dart';
import 'package:flutter_training_app/screens/side_menu_screens/main_menu.dart';

void main() {

    final store = Store<AppState>(
        appReducer,
        initialState: AppState(reduxSetup: true, loginAPIResponse: LoginAPIResponse(), postsResponse: [], commentsResponse: []),
        middleware: [thunkMiddleware],
    );

    runApp(StoreProvider(
        store: store,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/login',
            routes: {
                '/login': (context) => Login(),
                '/registration': (context) => Registration(),
                '/dashboard': (context) => MainMenu()
            }
        )));
}

