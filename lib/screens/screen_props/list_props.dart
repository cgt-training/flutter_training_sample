import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// Action
import 'package:flutter_training_app/actions/actions.dart';

// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';


// Summary: This will provide props to calling class.
class ListProps{

    final Function comments;
    final Function posts;
    final List<PostsResponse> listOfPosts;
    final List<CommentsResponse> listOfComments;

    ListProps({
        @required this.posts,
        @required this.comments,
        @required this.listOfPosts,
        @required this.listOfComments
    });

    ListProps mapStateToProps(Store<AppState> store){
        return ListProps(
            comments: () => store.dispatch(getCommentsThunkAction()),
            posts: () => store.dispatch(getPostsThunkAction()),
            listOfPosts: store.state.postsResponse,
            listOfComments: store.state.commentsResponse
        );
    }

}