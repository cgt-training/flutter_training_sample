import 'package:flutter/material.dart';

class CustomDialog{

    static Future<void> showDialogBox(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Processing'),
                    content: SingleChildScrollView(
                        child: ListBody(
                            children: <Widget>[
                                new CircularProgressIndicator(
                                )
                            ],
                        ),
                    )
                );
            },
        );
    }
}