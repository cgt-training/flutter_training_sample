import 'package:redux/redux.dart';

// Action
import 'package:flutter_training_app/actions/actions.dart';

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';

// Summary: Fetch the value from the CommentsAction and pass that value for further use.
final commentsReducers = TypedReducer<List<CommentsResponse>, CommentsAction>(commentReducer);

List<CommentsResponse> commentReducer(List<CommentsResponse> state, CommentsAction action){
    return action.commentsResponse;
}