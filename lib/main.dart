import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

//Models
import 'package:flutter_training_app/models/redux/redux_models.dart';

// Reducers
import 'package:flutter_training_app/reducers/app_reducer.dart';

// Reponse Model
import 'package:flutter_training_app/response_model/loginResponse.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/login.dart';
import 'package:flutter_training_app/screens/registration.dart';
import 'package:flutter_training_app/screens/side_menu_screens/main_menu.dart';

void main() {

    final store = Store<AppState>(
        appReducer,
        initialState: AppState(reduxSetup: true, loginAPIResponse: LoginAPIResponse(), postsResponse: PostsResponse()),
    );

    runApp(StoreProvider(
        store: store,
        child: MaterialApp(
            initialRoute: '/login',
            routes: {
                '/login': (context) => Login(),
                '/registration': (context) => Registration(),
                '/dashboard': (context) => MainMenu()
            }
        )));
}

