import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_training_app/response_model/comments_response.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Response Model
import 'package:flutter_training_app/response_model/posts_response.dart';

// Summary: this class will provide the insert statements for different tables in database.
class InsertTables{

    // Summary: Function will create the connection to database.
    Future<Database> dbConnection() async {
        Future<Database> database = openDatabase(
                join(await getDatabasesPath(), 'project_database.db'), version: 1);
//        Database db = await database;
        return database;
    }

    // Summary: insert the post in database.
    Future<void> insertPost(PostsResponse post) async {

        Future<Database> database = dbConnection();
        // Get a reference to the database.
        final Database db = await database;

        // Insert the post into the correct table. Also specify the `conflictAlgorithm`. In this case, if the same post is inserted
        // multiple times, it replaces the previous data.
        await db.insert(
            'posts',
            post.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
        );

    }

    // Summary: Insert multiple posts in database.
    Future<void> insertMultiplePost(List<PostsResponse> posts) async {
        Future<Database> database = dbConnection();
        // Get a reference to the database.
        final Database db = await database;

        for(var i=0; i < posts.length; i++){
            await db.insert(
                'posts',
                posts[i].toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
            );
        }
    }

    // Summary: this will return the data contain by posts table.
    Future<List<PostsResponse>> retrievePosts() async {

        Future<Database> database = dbConnection();
        final Database db = await database;
        var result = await db.rawQuery("select * from posts");

        List<PostsResponse> postsList = new List<PostsResponse>();

        for(var i=0; i < result.length; i++){

            PostsResponse post = new PostsResponse();
            post.id = result[i]['id'];
            post.userId = result[i]['userId'];
            post.title = result[i]['title'];
            post.body = result[i]['body'];

            postsList.add(post);
        }

        return postsList;
    }

    // Summary: This will insert the comment in database.
    Future<Void> insertComment(CommentsResponse comment) async {

        Future<Database> database = dbConnection();
        Database db = await database;

        db.insert(
            'Comments',
             comment.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace
        );
    }

    // Summary: Insert multiple comments in database table.
    Future<void> insertMultipleComments(List<CommentsResponse> comments) async {

        Future<Database> database = dbConnection();
        // Summary: Get a reference to the database.
        final Database db = await database;

        for(var i=0; i < comments.length; i++){
            await db.insert(
                'Comments',
                comments[i].toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
            );
        }
    }

    // Summary: Will return data contain by comment table.
    Future<List<CommentsResponse>> retrieveComments() async {

        Future<Database> database = dbConnection();
        Database db = await database;

        var result = await db.rawQuery("select * from Comments");
        List<CommentsResponse> listOfComments = new List<CommentsResponse>();

        for(var i=0; i < result.length; i++ ){

            CommentsResponse commentsResponse = new CommentsResponse();

            commentsResponse.id = result[i]['id'];
            commentsResponse.postId = result[i]['postId'];
            commentsResponse.name = result[i]['name'];
            commentsResponse.email = result[i]['email'];
            commentsResponse.body = result[i]['body'];

            listOfComments.add(commentsResponse);
        }

        return listOfComments;
//            result.toList();

    }
}