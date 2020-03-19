import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDialog{

    static Future<void> showDialogBox(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Processing'),
                    content: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                CircularProgressIndicator()
                            ],
                        )
                    )

                );
            },
        );
    }
}