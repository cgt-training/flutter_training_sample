
// Provide the initial state of response.
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Summary: This class will provide the initial state for reducers.
class LoginInitialState{

    LoginAPIResponse loginAPIResponseState;

    LoginInitialState({
        this.loginAPIResponseState
    });

    factory LoginInitialState.initial() => LoginInitialState(
        loginAPIResponseState: null
    );

}