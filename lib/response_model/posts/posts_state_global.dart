import 'package:flutter_training_app/response_model/posts/list_posts_state.dart';

class PostsStateGlobal{
    ListPostsState listPostsState;

    PostsStateGlobal({
       this.listPostsState
    });

    factory PostsStateGlobal.initial() => PostsStateGlobal(
        listPostsState: ListPostsState.initial()
    );
}