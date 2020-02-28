import 'package:redux/redux.dart';

// Actions
import 'package:flutter_training_app/actions/actions.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';


final postsReducers = TypedReducer<List<PostsResponse>, PostsAction>(postsReducersFunc);

List<PostsResponse> postsReducersFunc(List<PostsResponse> state, PostsAction action){

    return action.postsResponse;
}