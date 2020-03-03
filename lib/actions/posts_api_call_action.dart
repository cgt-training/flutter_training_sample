// Redux Dependency
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';


// Models
import 'package:flutter_training_app/models/redux/app_state.dart';

const LIST_POSTS_REQUEST = 'LIST_POSTS_REQUEST';
const LIST_POSTS_SUCCESS = 'LIST_POSTS_SUCCESS';
const LIST_POSTS_FAILURE = 'LIST_POSTS_FAILURE';

// Summary: Use this function to call the api. Pass the data to next middleware.
RSAA getPostsRequest() {
    print("getPostsRequest()");
    return
        RSAA(
            method: 'GET',
            endpoint: 'https://jsonplaceholder.typicode.com/posts',
            headers: {
                'Content-type': 'application/json'
            },
            types: [
                LIST_POSTS_REQUEST,
                LIST_POSTS_SUCCESS,
                LIST_POSTS_FAILURE
            ]
        );
}

ThunkAction<AppState> getPosts() => (Store<AppState> store) {
    print("ThunkAction<AppState> getPosts()");
    store.dispatch(getPostsRequest());
};
