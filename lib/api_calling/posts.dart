import 'dart:convert';
import 'package:flutter/material.dart';

// Actions
import 'package:flutter_training_app/actions/actions.dart';

// Dependency
import 'package:http/http.dart' as http;

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

class APICallPosts extends PostsAction{

    // Summary Get all the data from posts API.
    static Future<List<PostsResponse>> getPosts() async{

        final posts = await http.get('https://jsonplaceholder.typicode.com/posts');
        List<dynamic> body = json.decode(posts.body);

        //Summary: Map response data to create a list.
        List<PostsResponse> postsList = body.map((dynamic item) => PostsResponse.fromJson(item)).toList();

        if(posts.statusCode == 200){

            return postsList;
        }else{
            throw Exception('Failed to fetch posts');
//            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Not Working')));
        }
    }
}