import 'package:flutter/material.dart';
import 'package:flutter_training_app/authentication/login.dart';
import 'package:flutter_training_app/authentication/registration.dart';
void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/registration': (context) => Registration(),
    }
));




