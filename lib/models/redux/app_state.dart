import 'package:flutter_training_app/response_model/comments_response.dart';
import 'package:meta/meta.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';

@immutable
class AppState{
    final bool reduxSetup;
    final LoginAPIResponse loginAPIResponse;
    final List<PostsResponse> postsResponse;
    final List<CommentsResponse> commentsResponse;
    const AppState({
        @required this.reduxSetup,
        @required this.loginAPIResponse,
        @required this.postsResponse,
        @required this.commentsResponse
    });
}