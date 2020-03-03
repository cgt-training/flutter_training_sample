import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_training_app/models/redux/app_state.dart';
import 'package:flutter_training_app/screens/screen_props/posts_screen_props.dart';

class Screen2 extends StatelessWidget {
    void handleInitialBuild(PostsScreenProps props){
        props.getPosts();
    }
    @override
    Widget build(BuildContext context) {
        return StoreConnector<AppState, PostsScreenProps>(
            converter: (store) {
               return mapStateToProps(store);
            },
            onInitialBuild: (props){
                this.handleInitialBuild(props);
            },
            builder: (context, props){
                new Center(
                    child: new Text("Hello Screen2 :)"),
                );
            },
        );


    }
}