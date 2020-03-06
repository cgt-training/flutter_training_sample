import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response_Model
import 'package:flutter_training_app/response_model/loginResponse.dart';


class LoginProps{
    final LoginAPIResponse apiResponse;

    LoginProps({
       @required this.apiResponse
    });

    static LoginProps mapStateToProps(Store<AppState> store){
        return LoginProps(
            apiResponse: store.state.loginAPIResponse
        );
    }
}