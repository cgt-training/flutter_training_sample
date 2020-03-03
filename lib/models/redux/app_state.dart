import 'package:flutter_training_app/response_model/login/login_response_state.dart';
import 'package:meta/meta.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';
import 'package:flutter_training_app/response_model/posts/posts_state_global.dart';

@immutable
class AppState{
    final bool reduxSetup;
    final LoginStateGlobal loginStateGlobal;
    final List<PostsResponse> postsResponse;
    final PostsStateGlobal postsstate;

    const AppState({
        @required this.reduxSetup,
        @required this.loginStateGlobal,
        @required this.postsResponse,
        @required this.postsstate
    });

    factory AppState.initial() => AppState(
        reduxSetup: true,
        loginStateGlobal: LoginStateGlobal.initial(),
        postsResponse: List<PostsResponse>(),
        postsstate: PostsStateGlobal.initial()
    );
}