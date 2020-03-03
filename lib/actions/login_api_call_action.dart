import 'dart:convert';

// Redux
import 'package:redux/redux.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:redux_thunk/redux_thunk.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

const LIST_LOGIN_REQUEST = 'LIST_LOGIN_REQUEST';
const LIST_LOGIN_SUCCESS = 'LIST_LOGIN_SUCCESS';
const LIST_LOGIN_FAILURE = 'LIST_LOGIN_FAILURE';

// Summary: Redux action to call the api and return response which is handled by reducers.
RSAA postLoginRequest(){
    return RSAA(
        method: 'POST',
        endpoint: 'https://angular7-shopping-cart.herokuapp.com/api/login',
        headers: {
            'Content-type': 'application/json'
        },
        body: jsonEncode(<String, String>{
            'email': 'testing@vaib.com',
            'password': 'Sameer1@'
        }),
        types: [
            LIST_LOGIN_REQUEST,
            LIST_LOGIN_SUCCESS,
            LIST_LOGIN_FAILURE
        ],

    );
}

// Summary: Thunk Action which is dispatch from Login screen to call login API.
ThunkAction<AppState> loginAPICall() => (Store<AppState> store){
    store.dispatch(postLoginRequest());
};