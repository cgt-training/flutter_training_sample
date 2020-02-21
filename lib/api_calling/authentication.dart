import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

// Dependency
import 'package:http/http.dart' as http;

// Models
import 'package:flutter_training_app/models/login.dart';

// Response Models
import 'package:flutter_training_app/response_model/loginResponse.dart';

class ApiCallsInAuthentication{

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
//            return response;
        } else {
            throw Exception('Failed to login.');
        }
    }
}