import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//dependency
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomDialog{

    static Future<void> showDialogBox(BuildContext context) async {
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
                return AlertDialog(
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(20.0))
                           ),
                    content: Container(
                        height: 100,
                        width: 100,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                SpinKitWave(
                                    color: Colors.blueGrey,
                                    size: 50,
                                )
                            ],
                        )
                    )
                );
            },
        );
    }
}