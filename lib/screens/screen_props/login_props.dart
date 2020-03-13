import 'package:flutter/cupertino.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';
import 'package:redux/redux.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response_Model
import 'package:flutter_training_app/response_model/loginResponse.dart';


class LoginProps{
    final LoginAPIResponse apiResponse;
    final List<PostsResponse> postsList;
    LoginProps({
       @required this.apiResponse,
       @required this.postsList
    });

    static LoginProps mapStateToProps(Store<AppState> store){
        return LoginProps(
            apiResponse: store.state.loginAPIResponse,
            postsList: store.state.postsResponse
        );
    }
}