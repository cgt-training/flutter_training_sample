import 'package:flutter/material.dart';

class InformationDialog {


  static Future<void> passwordInformation(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Password should be in given format:'),
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                Text('1. Length of password must be greater than seven characters'),
                                Text('2. Must contain one capital & small letter, must contain one digit and special character'),
                            ],
                        ),
                    ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text('Close'),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }
}