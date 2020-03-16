import 'package:flutter_training_app/models/redux/redux_models.dart';
import 'package:flutter_training_app/reducers/comments_reducers.dart';

// Reducers
import 'package:flutter_training_app/reducers/login_reducers.dart';
import 'package:flutter_training_app/reducers/posts_reducers.dart';
import 'package:flutter_training_app/reducers/test_reducers.dart';


AppState appReducer(AppState state, action) {
    return AppState(
        reduxSetup: testReducer(state.reduxSetup, action),
        commentsResponse: commentsReducers(state.commentsResponse, action),
        loginAPIResponse: loginReducers(state.loginAPIResponse, action),
        postsResponse: postsReducers(state.postsResponse, action)
    );
}