
import 'dart:convert';

// Dependencies
import 'package:http/http.dart' as http;

// Response Model
import 'package:flutter_training_app/response_model/comments_response.dart';

// Summary: Call Comments API and set the data in list to return.
class APICallComments{

    static Future<List<CommentsResponse>> getCommentsFromAPI() async{

        http.Response response = await http.get("https://jsonplaceholder.typicode.com/comments");
        List<dynamic> responseData = json.decode(response.body);

        List<CommentsResponse> listComments = responseData.map((dynamic data) =>CommentsResponse.fromJson(data)).toList();

        if(response.statusCode == 200){

            return listComments;
        }else{
            throw Exception('Failed to fetch the comments');
        }
    }
}