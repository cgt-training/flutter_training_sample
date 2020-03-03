import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

// API_Calling
import 'package:flutter_training_app/api_calling/posts.dart';

// Model
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';


class PostsAction{
    final List<PostsResponse> postsResponse;
    PostsAction({
        this.postsResponse
    });

    // Summary: Thunk action used to call the posts API and dispatch it in the PostsAction.
    ThunkAction<AppState> getPostsData = (Store<AppState> store) async{
        print("ThunkAction<AppState> getPostsData()");

        List<PostsResponse> allPosts = await APICallPosts.getPosts();

        store.dispatch(PostsAction(postsResponse: allPosts));

    };
}