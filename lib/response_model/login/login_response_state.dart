// Response Model
import 'package:flutter_training_app/response_model/login/login_initial_state.dart';


// Summary: Provide the initial state to next stage in the redux.
class LoginStateGlobal{

    LoginInitialState loginAPIResponseState;

    LoginStateGlobal({
        this.loginAPIResponseState
    });

    //Summary: Provide the factory method for initial state.
    factory LoginStateGlobal.initial() => LoginStateGlobal(
        loginAPIResponseState: LoginInitialState.initial()
    );
}