import 'package:flutter/material.dart';

// Screens
import 'package:flutter_training_app/screens/login.dart';
import 'package:flutter_training_app/screens/registration.dart';
import 'package:flutter_training_app/screens/side_menu_screens/main_menu.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/registration': (context) => Registration(),
      '/dashboard': (context) => MainMenu()
    }
));




