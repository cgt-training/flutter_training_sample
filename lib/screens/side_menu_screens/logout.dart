import 'dart:async';
import 'package:flutter/material.dart';

// Summary: When logout button clicked this class will be called and after specified time it will navigate to Login.
class Logout extends StatelessWidget{
    Timer timer;
    Logout(){

    }
  @override
  Widget build(BuildContext context) {

    // Summary: This will start the function.
    timer = new Timer(const Duration(milliseconds: 1000), () {
        timer.cancel();
        Navigator.of(context).pop();
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
