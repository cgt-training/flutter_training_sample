import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Form
import 'package:flutter_training_app/screens/forms/loginForm.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.pink[500],
          title: Text('Login'),
          //centerTitle: true,
        ),
        body:
          Center(
            child: Scrollbar(
             child: SingleChildScrollView(
               child: Column(
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(top: 20, bottom: 20),
                     child: Image(image: AssetImage('assets/images/logo.png')),
                   ),
                   Container(
                     margin: EdgeInsets.only(top: 20),
                     child: Text(
                       'Welcome To Sample App',
                       style: TextStyle(
                           color: Colors.pink[500],
                           fontSize: 25.0
                       ),
                     ),
                   ),
                   LoginForm()
                 ],
               )
             )
            )

          )
    );
  }
}

