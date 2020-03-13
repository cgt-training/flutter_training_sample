import 'package:flutter/material.dart';
import 'package:flutter_training_app/actions/actions.dart';
import 'package:flutter_training_app/models/redux/app_state.dart';
import 'package:flutter_training_app/response_model/posts_response.dart';
import 'package:redux/redux.dart';

class ListProps{
    final Function posts;
    final List<PostsResponse> listOfPosts;
    ListProps({
        @required this.posts,
        @required this.listOfPosts
    });

    ListProps mapStateToProps(Store<AppState> store){
        return ListProps(
            posts: () => store.dispatch(getPostsThunkAction()),
            listOfPosts: store.state.postsResponse
        );
    }

}