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
        return database;
    }

    // Summary: insert the post in database.
    Future<void> insertPost(PostsResponse post) async {

        print("insertPost(PostsResponse post) async");
        print(post);

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

    // Summary: this will return the data contain by posts table.
    Future<List> retrievePosts() async {
        Future<Database> database = dbConnection();
        final Database db = await database;
        var result = await db.rawQuery("select * from posts");
        print("retrievePosts() async");
        print(result.toList());

        return result.toList();
    }

}