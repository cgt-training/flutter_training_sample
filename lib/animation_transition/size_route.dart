import 'package:flutter/material.dart';

// Summary: SizeRoute provide animation between pages.
class SizeRoute extends PageRouteBuilder {
    final Widget page;
    SizeRoute({this.page})
        : super(
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) =>
        page,
        transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) =>
            Align(
                child: SizeTransition(
                    sizeFactor: animation,
                    child: child,
                ),
            ),
    );
}
