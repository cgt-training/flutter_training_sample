import 'dart:convert';

// Redux Dependency
import 'package:redux_api_middleware/redux_api_middleware.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts/posts_state_global.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';

// Summary: Creates a reducer based on the action fired
PostsStateGlobal postsListReducer(PostsStateGlobal state, FSA action){

    PostsStateGlobal newState = PostsStateGlobal.initial();

    switch(action.type){
        case 'LIST_POSTS_REQUEST':
            print("Inside LIST_POSTS_REQUEST");
//             newState.listPostsState.postsResponseList = null;
            return newState;
        case 'LIST_POSTS_SUCCESS':
            print("Inside LIST_POSTS_SUCCESS");
            newState.listPostsState.postsResponseList = postsFromJSONStr(action.payload);
            return newState;
        case 'LIST_POSTS_FAILURE':
            print("Inside LIST_POSTS_FAILURE");
            newState.listPostsState.postsResponseList = null;
            return newState;
        default:
            return newState;

    }
}
List<PostsResponse> postsFromJSONStr(dynamic payload) {
    Iterable jsonArray = json .decode(payload);
    return jsonArray.map((j) => PostsResponse.fromJson(j)).toList();
}