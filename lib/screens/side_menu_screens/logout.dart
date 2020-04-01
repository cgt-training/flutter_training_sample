import 'dart:async';
import 'package:flutter/material.dart';

// Screens
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
      Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  settings: RouteSettings(name: '/login'),
                  builder: (context){
                      return Login();
                  }
              )
          );
//          Navigator.popUntil(context, ModalRoute.withName("/login"));

      });

      // TODO: implement build
      return new Center(
            child:  Container(
                margin: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator()
            )
      );
  }

}
