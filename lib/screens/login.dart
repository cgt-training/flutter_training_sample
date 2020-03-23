import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';
import 'package:flutter_training_app/Forms/registrationForm.dart';

// Dependencies
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Util
import 'package:flutter_training_app/util/tab_indication_painter.dart';
import 'package:flutter_training_app/util/style/theme.dart' as Theme;

// Summary: This is login UI file.
class Login extends StatefulWidget {
    Login({Key key}) : super(key: key);

    @override
    _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<Login> with SingleTickerProviderStateMixin {

    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


    final FocusNode myFocusNodePassword = FocusNode();
    final FocusNode myFocusNodeEmail = FocusNode();
    final FocusNode myFocusNodeName = FocusNode();

    bool _obscureTextLogin = true;
    bool _obscureTextSignup = true;
    bool _obscureTextSignupConfirm = true;

    TextEditingController signupEmailController = new TextEditingController();
    TextEditingController signupNameController = new TextEditingController();
    TextEditingController signupPasswordController = new TextEditingController();
    TextEditingController signupConfirmPasswordController = new TextEditingController();

    PageController _pageController;

    Color left = Colors.black;
    Color right = Colors.white;

    @override
    void initState() {
        super.initState();

        SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
        ]);

        _pageController = PageController();
    }

    @override
    Widget build(BuildContext context) {
        print("MediaQuery.of(context).size.width");
        print(MediaQuery.of(context).size.width);
        return new Scaffold(
            key: _scaffoldKey,
            body: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                    overscroll.disallowGlow();
                },
                child: Scrollbar(
                    child: SingleChildScrollView(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height >= 775.0
                                ? MediaQuery.of(context).size.height
                                : 875.0,
                            decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                        Theme.Colors.loginGradientStart,
                                        Theme.Colors.loginGradientEnd
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(top: 50.0),
                                        child: new Image(
                                            width: 250.0,
                                            height: 150.0,
                                            fit: BoxFit.fill,
                                            image: new AssetImage('assets/images/login_logo.png')),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: _buildMenuBar(context),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: PageView(
                                            controller: _pageController,
                                            onPageChanged: (i) {
                                                if (i == 0) {
                                                    setState(() {
                                                        right = Colors.white;
                                                        left = Colors.black;
                                                    });
                                                } else if (i == 1) {
                                                    setState(() {
                                                        right = Colors.black;
                                                        left = Colors.white;
                                                    });
                                                }
                                            },
                                            children: <Widget>[
                                                new ConstrainedBox(
                                                    constraints: const BoxConstraints.expand(),
                                                    child: LoginForm()
                                                    //                                                _buildSignIn(context),
                                                ),
                                                new ConstrainedBox(
                                                    constraints: const BoxConstraints.expand(),
                                                    child: RegistrationForm()
                                                    //                                                _buildSignUp(context),
                                                ),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                )
            ),
        );
    }

    @override
    void dispose() {
//        myFocusNodePassword.dispose();
//        myFocusNodeEmail.dispose();
//        myFocusNodeName.dispose();
        _pageController?.dispose();
        super.dispose();
    }


    void showInSnackBar(String value) {
        FocusScope.of(context).requestFocus(new FocusNode());
        _scaffoldKey.currentState?.removeCurrentSnackBar();
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold"),
            ),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 3),
        ));
    }

    Widget _buildMenuBar(BuildContext context) {

        double indicatorWidth = MediaQuery.of(context).size.width < 599 ? MediaQuery.of(context).size.width * .33 : MediaQuery.of(context).size.width * .36;
        return Container(
            width: MediaQuery.of(context).size.width * .8,
            height: 50.0,
            decoration: BoxDecoration(
                color: Color(0x552B2B2B),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: CustomPaint(
                painter: TabIndicationPainter( dxTarget: indicatorWidth, pageController: _pageController),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                        Expanded(
                            child: FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: _onSignInButtonPress,
                                child: Text(
                                    "Existing",
                                    style: TextStyle(
                                        color: left,
                                        fontSize: 16.0,
                                        fontFamily: "WorkSansSemiBold"),
                                ),
                            ),
                        ),
                        //Container(height: 33.0, width: 1.0, color: Colors.white),
                        Expanded(
                            child: FlatButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onPressed: _onSignUpButtonPress,
                                child: Text(
                                    "New",
                                    style: TextStyle(
                                        color: right,
                                        fontSize: 16.0,
                                        fontFamily: "WorkSansSemiBold"
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _buildSignUp(BuildContext context) {
        return Container(
            padding: EdgeInsets.only(top: 23.0),
            child: Column(
                children: <Widget>[
                    Stack(
                        alignment: Alignment.topCenter,
                        overflow: Overflow.visible,
                        children: <Widget>[
                            Card(
                                elevation: 2.0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                    width: 300.0,
                                    height: 360.0,
                                    child: Column(
                                        children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                child: TextField(
                                                    focusNode: myFocusNodeName,
                                                    controller: signupNameController,
                                                    keyboardType: TextInputType.text,
                                                    textCapitalization: TextCapitalization.words,
                                                    style: TextStyle(
                                                        fontFamily: "WorkSansSemiBold",
                                                        fontSize: 16.0,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                            FontAwesomeIcons.user,
                                                            color: Colors.black,
                                                        ),
                                                        hintText: "Name",
                                                        hintStyle: TextStyle(
                                                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                width: 250.0,
                                                height: 1.0,
                                                color: Colors.grey[400],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                child: TextField(
                                                    focusNode: myFocusNodeEmail,
                                                    controller: signupEmailController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    style: TextStyle(
                                                        fontFamily: "WorkSansSemiBold",
                                                        fontSize: 16.0,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                            FontAwesomeIcons.envelope,
                                                            color: Colors.black,
                                                        ),
                                                        hintText: "Email Address",
                                                        hintStyle: TextStyle(
                                                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                width: 250.0,
                                                height: 1.0,
                                                color: Colors.grey[400],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                child: TextField(
                                                    focusNode: myFocusNodePassword,
                                                    controller: signupPasswordController,
                                                    obscureText: _obscureTextSignup,
                                                    style: TextStyle(
                                                        fontFamily: "WorkSansSemiBold",
                                                        fontSize: 16.0,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                            FontAwesomeIcons.lock,
                                                            color: Colors.black,
                                                        ),
                                                        hintText: "Password",
                                                        hintStyle: TextStyle(
                                                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                                        suffixIcon: GestureDetector(
                                                            onTap: _toggleSignup,
                                                            child: Icon(
                                                                FontAwesomeIcons.eye,
                                                                size: 15.0,
                                                                color: Colors.black,
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                width: 250.0,
                                                height: 1.0,
                                                color: Colors.grey[400],
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                child: TextField(
                                                    controller: signupConfirmPasswordController,
                                                    obscureText: _obscureTextSignupConfirm,
                                                    style: TextStyle(
                                                        fontFamily: "WorkSansSemiBold",
                                                        fontSize: 16.0,
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        icon: Icon(
                                                            FontAwesomeIcons.lock,
                                                            color: Colors.black,
                                                        ),
                                                        hintText: "Confirmation",
                                                        hintStyle: TextStyle(
                                                            fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                                        suffixIcon: GestureDetector(
                                                            onTap: _toggleSignupConfirm,
                                                            child: Icon(
                                                                FontAwesomeIcons.eye,
                                                                size: 15.0,
                                                                color: Colors.black,
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 340.0),
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Theme.Colors.loginGradientStart,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0,
                                        ),
                                        BoxShadow(
                                            color: Theme.Colors.loginGradientEnd,
                                            offset: Offset(1.0, 6.0),
                                            blurRadius: 20.0,
                                        ),
                                    ],
                                    gradient: new LinearGradient(
                                        colors: [
                                            Theme.Colors.loginGradientEnd,
                                            Theme.Colors.loginGradientStart
                                        ],
                                        begin: const FractionalOffset(0.2, 0.2),
                                        end: const FractionalOffset(1.0, 1.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                ),
                                child: MaterialButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Theme.Colors.loginGradientEnd,
                                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 42.0),
                                        child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25.0,
                                                fontFamily: "WorkSansBold"),
                                        ),
                                    ),
                                    onPressed: () =>
                                        showInSnackBar("SignUp button pressed")),
                            ),
                        ],
                    ),
                ],
            ),
        );
    }

    void _onSignInButtonPress() {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    }

    void _onSignUpButtonPress() {
        _pageController?.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.decelerate);
    }

    void _toggleSignup() {
        setState(() {
            _obscureTextSignup = !_obscureTextSignup;
        });
    }

    void _toggleSignupConfirm() {
        setState(() {
            _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
        });
    }
}

