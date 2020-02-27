import 'dart:io';
import 'package:flutter/material.dart';

class Connectivity{
    static Future<InternetAddress> networkConnection(BuildContext context) async{
        bool returnValue;
        final result = await InternetAddress.lookup('google.com');
        if(result.length > 0){
            return result[0];
        }
    }
}