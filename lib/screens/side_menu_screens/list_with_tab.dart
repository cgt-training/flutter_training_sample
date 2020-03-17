import 'package:flutter/material.dart';

// Screens
import 'package:flutter_training_app/screens/side_menu_screens/comments.dart';
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';

// Summary: provide the tab functionality with list.
class ListsWithTab extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.pink[800], //Changing this will change the color of the TabBar
                accentColor: Colors.cyan[600],
            ),
            home: DefaultTabController(
                length: 2,
                child:
                    Scaffold(
                        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
//                        bottomNavigationBar:
                        appBar: AppBar(
                            title: Text('Tab With Lists'),
                            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                            bottom: TabBar(
                                indicatorColor: Colors.white,
                                indicatorSize: TabBarIndicatorSize.label,
                                unselectedLabelColor: Colors.red,
                                tabs: <Widget>[
                                    Tab(
                                        icon: Icon(Icons.local_post_office),
                                        child: Text("Posts"),
                                    ),
                                    Tab(
                                        icon: Icon(Icons.insert_comment),
                                        child: Text("Comments"),
                                    )
                                ],
                            ),
                        ),
                        body: TabBarView(
                                children: <Widget>[
                                    Posts(),
                                    Comments()
                                ],
                            ),
                    ),
            )
        );

    }
}