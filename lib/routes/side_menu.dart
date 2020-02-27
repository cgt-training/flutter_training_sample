import 'package:flutter/material.dart';

// Models
import 'package:flutter_training_app/models/menuItem.dart';

//Screens
import 'package:flutter_training_app/screens/side_menu_screens/dashboard.dart';
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';
import 'package:flutter_training_app/screens/side_menu_screens/screen2.dart';


class SideMenuItems{

    static List<MenuItem> createMenuItems(BuildContext context) {
        final menuItems = [
            new MenuItem(
                "Dashboard", 'assets/images/dashboard.png', Colors.black,
                    () => Dashboard()),
            new MenuItem(
                "Screen 2", 'assets/images/dashboard.png', Colors.black,
                    () => Screen2()),
            new MenuItem("Posts", 'assets/images/dashboard.png', Colors.black,
                    ()=> Posts()),
            new MenuItem("Logout", 'assets/images/dashboard.png', Colors.black,
                    ()=> Navigator.of(context).pop())
        ];
        return menuItems;
    }
}