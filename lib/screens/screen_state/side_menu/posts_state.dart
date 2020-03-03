import 'package:flutter/material.dart';
import 'package:flutter_training_app/screens/screen_props/posts_screen_props.dart';
import 'package:flutter_redux/flutter_redux.dart';


// Api Calling
import 'package:flutter_training_app/models/redux/app_state.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Screens
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';

// UI Elements
import 'package:flutter_training_app/ui_elements/row_listview.dart';

class PostsState extends State<Posts>{

    List<PostsResponse> postsResponseData;
    int lengthOfData;


    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        print("init State");
    }

    void handleInitialBuild(PostsScreenProps props){
        props.getPosts();
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build

        return StoreConnector<AppState, PostsScreenProps>(
            converter: (store){
               return mapStateToProps(store);
            },
            onInitialBuild: (props) {

               this.handleInitialBuild(props);
            },
            builder: (context, props){
                int lengthData = props.listPostsState.listPostsState.postsResponseList.length > 0 ? props.listPostsState.listPostsState.postsResponseList.length : 0;
                if(lengthData > 0){
                    List<PostsResponse> posts = props.listPostsState.listPostsState.postsResponseList;
                    return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index){
                            return RowListView.postListRow(posts[index], index);
                        });
                }else{
                    return Center(child: CircularProgressIndicator());
                }
            }
        );

    }

//    @override
//    Widget build(BuildContext context) {
//        print("build");
//        // TODO: implement build
//        return FutureBuilder(
//            future: APICallPosts.getPosts(),
//            builder: (BuildContext context, AsyncSnapshot<List<PostsResponse>> responseData){
//
//                if(responseData.hasData){
//                    List<PostsResponse> posts = responseData.data;
//                    return ListView.builder(
//                        itemCount: posts.length,
//                        itemBuilder: (context, index){
//                            return RowListView.postListRow(posts[index], index);
//                        });
//                }else{
//                    return Center(child: CircularProgressIndicator());
//                }
//            },
//        );
//
//    }
}