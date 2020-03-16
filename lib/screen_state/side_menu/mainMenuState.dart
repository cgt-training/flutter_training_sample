import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training_app/screens/side_menu_screens/dashboard.dart';
import 'package:flutter_training_app/screens/side_menu_screens/list_with_tab.dart';
import 'package:flutter_training_app/screens/side_menu_screens/logout.dart';
import 'package:flutter_training_app/screens/side_menu_screens/posts.dart';
import 'package:flutter_training_app/screens/side_menu_screens/profile.dart';
import 'package:flutter_training_app/util/colors.dart';
import 'package:redux/redux.dart';

// Models
import 'package:flutter_training_app/models/menuItem.dart';
import 'package:flutter_training_app/models/redux/app_state.dart';

//Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Routes
import 'package:flutter_training_app/routes/side_menu.dart';

// Screens
import 'package:flutter_training_app/screens/screen_props/login_props.dart';
import 'package:flutter_training_app/screens/side_menu_screens/main_menu.dart';


class MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {

    TabController tabController;

    Store<AppState> store;
    LoginAPIResponse loginAPIResponseObj;

    // Summary: Class constructor for creating the tab controller.
    MainMenuState(){
        tabController = TabController(length: 5, vsync: this);
    }

    // Summary: initialized the state with first item returned by createMenuItems
    @override
    initState() {
        super.initState();

        print('_HomePageState initState');

        tabController.addListener(() {
            if (tabController.indexIsChanging && tabController.previousIndex != tabController.index) {
                setState(() {});
            }
        });
    }

    // TODO(clocksmith): Use icons.
    List<Widget> _buildTabs() {
        return <Widget>[
            _buildTab(Icons.pie_chart, "DASHBOARD", 0),
            _buildTab(Icons.attach_money, "TABEXAMPLE", 1),
            _buildTab(Icons.money_off, "POSTS", 2),
            _buildTab(Icons.table_chart, "PROFILE", 3), // TODO(clocksmith): This should be Icons.bar_chart, but its currently unavalableflutter
            _buildTab(Icons.add_to_home_screen, "LOGOUT", 4),
        ];
    }

    Widget _buildTab(IconData iconData, String title, int index) {
        return _RallyTab(Icon(iconData), title, tabController.index == index);
    }

    List<Widget> _buildTabViews(BuildContext context) {
        return <Widget>[
            Dashboard(),
            ListsWithTab(),
            Posts(),
            Profile(),
            Logout()
        ];
    }

    ThemeData _buildRallyTheme() {
        final ThemeData base = ThemeData.dark();
        return ThemeData(
            scaffoldBackgroundColor: RallyColors.pageBg,
            primaryColor: RallyColors.pageBg,
            textTheme: _buildRallyTextTheme(base.textTheme),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                    color: RallyColors.gray,
                    fontWeight: FontWeight.w500
                ),
                filled: true,
                fillColor: RallyColors.inputBg,
                focusedBorder: InputBorder.none,
            ),
        );
    }

    TextTheme _buildRallyTextTheme(TextTheme base) {
        return base.copyWith(
            body1:base.body1.copyWith(
                fontFamily: "Roboto Condensed",
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
            ),
            body2: base.body2.copyWith(
                fontFamily: "Eczar",
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
            ),
        ).apply(
            displayColor: Colors.white,
            bodyColor: Colors.white,
        );
    }


    @override
    Widget build(BuildContext context) {

        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store){

                return LoginProps.mapStateToProps(store);
            },
            builder: (context, props){
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: Scaffold(
                        body: SafeArea(
                            child: Column(
                                children: <Widget>[
                                    Theme(
                                        // This theme effectively removes the default visual touch
                                        // feedback for tapping a tab, which is replaced with a custom
                                        // animation.
                                        data: Theme.of(context).copyWith(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                        ),
                                        child: TabBar(
                                            // setting isScrollable to true prevents the tabs from being
                                            // wrapped in [Expanded] widgets, which allows for more
                                            // flexible sizes and size animations among tabs.
                                            isScrollable: true,
                                            labelPadding: EdgeInsets.zero,
                                            tabs: _buildTabs(),
                                            controller: tabController,
                                            // This effectively removes the tab indicator.
                                            indicator: UnderlineTabIndicator(
                                                borderSide: BorderSide(style: BorderStyle.none)
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        child: TabBarView(
                                            children: _buildTabViews(context),
                                            controller: tabController
                                        ),
                                    )
                                ]),
                        )
                    ),
                    theme: _buildRallyTheme(),
                );
            },
        );

    }

    @override
    void dispose() {
        // TODO: implement dispose
        super.dispose();
        print("Dispose from MAIN MENU");
    }

}


class _RallyTab extends StatefulWidget {
    Text titleText;
    Icon icon;
    bool isExpanded;

    _RallyTab(
        Icon icon,
        String title,
        bool isExpanded) {
        titleText = Text(title);
        this.icon = icon;
        this.isExpanded = isExpanded;
    }

    _RallyTabState createState() => _RallyTabState();
}

class _RallyTabState extends State<_RallyTab> with SingleTickerProviderStateMixin {
    Animation<double> _titleSizeAnimation;
    Animation<double> _titleFadeAnimation;
    // TODO(clocksmith): Use this to animate the opacity of the icons
    Animation<double> _iconFadeAnimation;
    AnimationController _controller;

    @override
    initState() {
        super.initState();
        _controller = AnimationController(
            duration: Duration(milliseconds: 200),
            vsync: this
        );
        _titleSizeAnimation = CurvedAnimation(
            parent: Tween(begin: 0.0, end: 1.0).animate(_controller),
            curve: Curves.linear
        );
        _titleFadeAnimation = CurvedAnimation(
            parent: Tween(begin: 0.0, end: 1.0).animate(_controller),
            curve: Curves.easeOut
        );
        _iconFadeAnimation = CurvedAnimation(
            parent: Tween(begin: 0.6, end: 1.0).animate(_controller),
            curve: Curves.linear
        );
        if (widget.isExpanded) {
            _controller.value = 1.0;
        }
    }

    @override
    void didUpdateWidget(_RallyTab oldWidget) {
        super.didUpdateWidget(oldWidget);
        if (widget.isExpanded) {
            _controller.forward();
        } else {
            _controller.reverse();
        }
    }

    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;

        // TODO(clocksmith): Calculate the widths of the inner boxes to take the exact required space.
        return SizedBox(
            height: 56.0,
            child: Row(
                children: <Widget>[
                    SizedBox(
                        width: width / 7,
                        child: widget.icon,
                    ),
                    FadeTransition(
                        child: SizeTransition(
                            child: SizedBox(
                                width: width / 4,
                                child: Center(child: widget.titleText),
                            ),
                            axis: Axis.horizontal,
                            axisAlignment: -1.0,
                            sizeFactor: _titleSizeAnimation,
                        ),
                        opacity: _titleFadeAnimation,

                    ),

                ],
            ),
        );
    }

    dispose() {
        _controller.dispose();
        super.dispose();
    }
}
