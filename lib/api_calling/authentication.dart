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

    static Future<RegisterAPIResponse> registerApi(RegisterModel registerObj, BuildContext context) async{

        Dio dio = new Dio();
        FormData formData = new FormData();
        formData.fields..add(MapEntry("username", registerObj.username))..add(MapEntry("email", registerObj.email))..add(MapEntry("password", registerObj.password));
        formData.files.add(MapEntry("profile", await MultipartFile.fromFile(registerObj.profileImageData, filename: "profile.png")));

        final response = await dio.post(
          'http://192.168.100.137:3000/api/register1',
           options: Options(
               headers: {
                   'x-token': '5'
               }
           ),
           data: formData
        ).
        catchError((error)=>{
            print("error")
        });
        print("Response Object");
        print(response.data);
        if(response.statusCode == 200){
            return RegisterAPIResponse.fromJson(response.data);
        }
//        else{
//            return "Not Login";
//        }
    }
}