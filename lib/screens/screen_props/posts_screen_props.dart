import 'package:redux/redux.dart';

// Actions
import 'package:flutter_training_app/actions/posts_api_call_action.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts/posts_state_global.dart';

// Summary: This class provide the props to posts screen and store connector.
class PostsScreenProps{
    final Function getPosts;
    final PostsStateGlobal listPostsState;

    PostsScreenProps({
        this.getPosts,
        this.listPostsState
    });
}

PostsScreenProps mapStateToProps(Store<AppState> store){

    return PostsScreenProps(
        getPosts: () => store.dispatch(getPosts()),
        listPostsState: store.state.postsstate
    );
}