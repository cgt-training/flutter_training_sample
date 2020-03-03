import 'dart:convert';

import 'package:redux_api_middleware/redux_api_middleware.dart';

// Response Model
import 'package:flutter_training_app/response_model/login/login_response_state.dart';
import 'package:flutter_training_app/response_model/loginResponse.dart';

LoginStateGlobal loginStateGlobalReducer(LoginStateGlobal state, FSA action){

    LoginStateGlobal newState = LoginStateGlobal.initial();

    switch(action.type){
        case 'LIST_LOGIN_REQUEST':
            print("From LIST_LOGIN_REQUEST");
            return newState;
        case 'LIST_LOGIN_SUCCESS':
            print("From LIST_LOGIN_SUCCESS");
            newState.loginAPIResponseState.loginAPIResponseState = jsonFromString(action.payload);
            return newState;
        case 'LIST_LOGIN_FAILURE':
            print("From LIST_LOGIN_FAILURE");
            return newState;

    }
}

LoginAPIResponse jsonFromString(dynamic payload){

    return LoginAPIResponse.fromJson(json.decode(payload));
}