import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

// Dependency
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

// Models
import 'package:flutter_training_app/models/login.dart';
import 'package:flutter_training_app/models/register.dart';

// Response Models
import 'package:flutter_training_app/response_model/loginResponse.dart';
import 'package:flutter_training_app/response_model/registerResponse.dart';

class ApiCallsInAuthentication{

    // Summary: Future type is used for async requests and this action will fetch the login details & set the response in LoginAPIResponse.
    static Future<LoginAPIResponse> loginApi(LoginModel loginObj, BuildContext context) async {
        final http.Response response = await http.post(
            'https://angular7-shopping-cart.herokuapp.com/api/login',
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
                'email': loginObj.email,
                'password': loginObj.password
            }),
        );

        if (response.statusCode == 200) {

            return LoginAPIResponse.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to login.');
        }
    }

    // Summary: This is used to call registration API.
    static Future<RegisterAPIResponse> registerApi(RegisterModel registerObj, BuildContext context) async{

        final http.Response response = await http.post(
            'http://192.168.100.137:3000/api/register',
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
                'email': registerObj.email,
                'password': registerObj.password,
                'username': registerObj.username
            }),
        );

        if (response.statusCode == 200) {
            return RegisterAPIResponse.fromJson(json.decode(response.body));
//            return LoginAPIResponse.fromJson(json.decode(response.body));
        } else {
            throw Exception('Failed to login.');
        }

//        Dio dio = new Dio();
//        FormData formData = new FormData();
//        formData.fields..add(MapEntry("username", registerObj.username))..add(MapEntry("email", registerObj.email))..add(MapEntry("password", registerObj.password));
//
//        // Upload file using FormData.
////        formData.files.add(MapEntry("profile", await MultipartFile.fromFile(AssetImage('assets/images/login_logo.png').toString(), filename: "profile.png")));
//
//        final response = await dio.post(
//          'http://192.168.100.137:3000/api/register',
//           options: Options(
//               headers: {
//                   'x-token': '5',
//                   'Content-Type': 'application/json; charset=UTF-8',
//               }
//           ),
//           data: formData
//        ).
//        catchError((error)=>{
//            print("error")
//        });
//        if(response.statusCode == 200){
//            return RegisterAPIResponse.fromJson(response.data);
//        }
    }
}