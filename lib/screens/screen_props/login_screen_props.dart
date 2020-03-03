import 'package:redux/redux.dart';

// Action
import 'package:flutter_training_app/actions/login_api_call_action.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/login/login_response_state.dart';

// Summary: Model call for the props used in login to dispatch and fetch state object.
class LoginScreenProps{
    final Function loginAPICall;
    final LoginStateGlobal apiResponse;

    LoginScreenProps({
        this.loginAPICall,
        this.apiResponse
    });
}

LoginScreenProps mapStateToProps(Store<AppState> store){
    print("LoginScreenProps mapStateToProps");
    print(store.state.loginStateGlobal);
    return LoginScreenProps(
        loginAPICall: () => store.dispatch(loginAPICall()),
        apiResponse: store.state.loginStateGlobal
    );
}