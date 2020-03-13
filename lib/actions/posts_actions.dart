import 'package:flutter_training_app/api_calling/posts.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


// Response Model
import 'package:flutter_training_app/models/redux/app_state.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';


class PostsAction{
    final List<PostsResponse> postsResponse;
    PostsAction({
        this.postsResponse
    });
}


ThunkAction<AppState> getPostsThunkAction() {

    return (Store<AppState> store) async {
        List<PostsResponse> posts = await APICallPosts.getPosts();
        store.dispatch(PostsAction(postsResponse: posts));
    };
}