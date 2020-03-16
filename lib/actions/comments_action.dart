import 'package:flutter/material.dart';
import 'package:flutter_training_app/api_calling/api_call_comments.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


// Model
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';


// Summary: This is action which will provide data to reducers.
class CommentsAction{

    final List<CommentsResponse> commentsResponse;

    CommentsAction({
        @required this.commentsResponse
    });
}

// Summary: ThunkAction will fetch data from API and will pass data to CommentsAction.
ThunkAction<AppState> getCommentsThunkAction() {

    return (Store<AppState> store) async{
        List<CommentsResponse> comments = await APICallComments.getCommentsFromAPI();
        store.dispatch(CommentsAction(commentsResponse: comments));
    };
}
