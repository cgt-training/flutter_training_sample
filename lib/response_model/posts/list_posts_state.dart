// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Summary: This class provides the initial state for posts list.
class ListPostsState{

    List<PostsResponse> postsResponseList;

    ListPostsState({ this.postsResponseList });

    factory ListPostsState.initial() => ListPostsState(
        postsResponseList:[]
    );
}