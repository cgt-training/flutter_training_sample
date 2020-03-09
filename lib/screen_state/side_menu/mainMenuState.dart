import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

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


class MainMenuState extends State<MainMenu> {
    Widget _appBarTitle;
    Color _appBarBackgroundColor;
    MenuItem _selectedMenuItem;
    List<MenuItem> _menuItems;
    List<Widget> _menuOptionWidgets = [];

    Store<AppState> store;
    LoginAPIResponse loginAPIResponseObj;

    // Summary: initialized the state with first item returned by createMenuItems
    @override
    initState() {
        super.initState();

        _menuItems = SideMenuItems.createMenuItems(context);
        _selectedMenuItem = _menuItems[0];
        _appBarTitle = Text(_menuItems[0].title);
        _appBarBackgroundColor = _menuItems[0].color;
    }

    // Summary: this will return which class one want to open.
    _getMenuItemWidget(MenuItem menuItem) {
        return menuItem.func();
    }

    // Summary: When any link is tapped on side menu then this function will be triggered.
    _onSelectItem(MenuItem menuItem) {
        setState(() {
            _selectedMenuItem = menuItem;
            _appBarTitle = Text(menuItem.title);
            _appBarBackgroundColor = menuItem.color;
        });
        Navigator.of(context).pop(); // close side menu
    }

    // Summary: Function will provide the UI for each row of menuItem.
    List<Widget> _createMenuOptionWidgets(){
        _menuOptionWidgets = [];

        for (var menuItem in _menuItems) {
            _menuOptionWidgets.add(Container(
                decoration: BoxDecoration(
                    color: menuItem == _selectedMenuItem
                        ? Colors.grey[200]
                        : Colors.white),
                child: ListTile(
                    leading: Image.asset(menuItem.icon),
                    onTap: () => _onSelectItem(menuItem),
                    title: Text(
                        menuItem.title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: menuItem.color,
                            fontWeight: menuItem == _selectedMenuItem
                                ? FontWeight.bold
                                : FontWeight.w300),
                    ))));

            // Add Separator line between two rows
            _menuOptionWidgets.add(
                SizedBox(
                    child: Center(
                        child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 20.0, end: 20.0),
                            height: 0.3,
                            color: Colors.grey,
                        ),
                    ),
                ),
            );
        }
        return _menuOptionWidgets;
    }


    @override
    Widget build(BuildContext context) {

        return StoreConnector<AppState, LoginProps>(
            converter: (Store<AppState> store){

                return LoginProps.mapStateToProps(store);
            },
            builder: (context, props){
                return Scaffold(
                    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
                    appBar: AppBar(
                        title: _appBarTitle,
                        backgroundColor: _appBarBackgroundColor,
                        centerTitle: true,
                    ),
                    // Summary: This will provide the side menu from left and inside the body different Screens will navigate.
                    drawer: Drawer(
                        child: ListView(
                            children: <Widget>[
                                Container(
                                    child: ListTile(
                                        leading: Image.asset('assets/images/lion.png'),
                                        title: Text(props.apiResponse.email)),
                                    margin: EdgeInsetsDirectional.only(top: 20.0),
                                    color: Colors.white,
                                    constraints: BoxConstraints(
                                        maxHeight: 90.0, minHeight: 90.0)),
                                SizedBox(
                                    child: Center(
                                        child: Container(
                                            margin: EdgeInsetsDirectional.only( start: 10.0, end: 10.0 ),
                                            height: 0.3,
                                            color: Colors.black,
                                        ),
                                    ),
                                ),
                                new Container(
                                    color: Colors.white,
                                    child: new Column(children: this._createMenuOptionWidgets()),
                                ),
                            ],
                        ),
                    ),
                    body: _getMenuItemWidget(_selectedMenuItem),


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