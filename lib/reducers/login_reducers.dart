import 'package:redux/redux.dart';

// Actions
import 'package:flutter_training_app/actions/actions.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Summary TypedReducer returns first argument and second argument is action.
final loginReducers = TypedReducer<LoginAPIResponse, LoginAction>(loginReducerFunc);

// This function is passed in the argument of TypedReducer.
LoginAPIResponse loginReducerFunc(LoginAPIResponse state, LoginAction action){

    return action.loginAPIActionResponse;
}