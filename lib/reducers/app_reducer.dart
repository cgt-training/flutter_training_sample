// Models
import 'package:flutter_training_app/models/redux/redux_models.dart';
import 'package:flutter_training_app/reducers/login_reducers_api.dart';
import 'package:flutter_training_app/reducers/posts_reducers_api.dart';

// Reducers
import 'package:flutter_training_app/reducers/test_reducers.dart';
import 'package:flutter_training_app/reducers/login_reducers.dart';
import 'package:flutter_training_app/reducers/posts_reducers.dart';

AppState appReducer(AppState state, action) {
    return AppState(
        reduxSetup: testReducer(state.reduxSetup, action),
//        loginAPIResponse: loginReducers(state.loginAPIResponse, action),
        loginStateGlobal: loginStateGlobalReducer(state.loginStateGlobal, action),
        postsResponse: postsReducers(state.postsResponse, action),
        postsstate: postsListReducer(state.postsstate, action)
    );
}