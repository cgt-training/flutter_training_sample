import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
          Center(
            child: Scrollbar(
             child: SingleChildScrollView(
               child: Column(
                 children: <Widget>[
                   Container(
                     margin: EdgeInsets.only(top: 0, bottom: 5),
                     child: Image(image: AssetImage('assets/images/logo.png')),
                   ),
                   Container(
                     margin: EdgeInsets.only(top: 20),
                     child: Text(
                       'Sample',
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

