import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training_app/screens/login.dart';

// Summary: When logout button clicked this class will be called and after specified time it will navigate to Login.
class Logout extends StatelessWidget{
    Timer timer;
    Logout(){
//        Navigator.of(context, rootNavigator: true).push(
//            MaterialPageRoute(
//                builder: (context){
//                    return Login();
//                }
//            )
//        );
    }
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return new Center(
            child:  Container(
                margin: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator()
            )
    );
  }

}
