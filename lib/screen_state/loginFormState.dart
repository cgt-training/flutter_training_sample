import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Action
import 'package:flutter_training_app/actions/login_actions.dart';

// ApiCaliing
import 'package:flutter_training_app/api_calling/authentication.dart';

// DBoperation
import 'package:flutter_training_app/db_operations/create_tables.dart';

// Dependencies
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';

// Model
import 'package:flutter_training_app/models/login.dart';
import 'package:flutter_training_app/models/redux/redux_models.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Screens
import 'package:flutter_training_app/screens/screen_props/list_props.dart';

// UI Elements
import 'package:flutter_training_app/ui_elements/customDialog.dart';
import 'package:flutter_training_app/ui_elements/information_Dialog.dart';

// Util
import 'package:flutter_training_app/util/style/theme.dart' as Theme;

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';
import 'package:flutter_training_app/util/connectivity.dart';

// Summary: This class holds data related to the login form and also maintains the state of data.
class LoginFormState extends State<LoginForm> {

    // Summary: local variables
    int flag = 0;
    double heightOfLoginContainer = 235.0;
    double marginFromTopLogin = 210.0;

    bool testRedux;
    LoginAPIResponse loginAPIResponseState;
    Store<AppState> store;

    // Summary: Form variables
    FocusNode txtEmail = new FocusNode();
    FocusNode txtPassword = new FocusNode();
    final _formKey = GlobalKey<FormState>(); // Note: This is a GlobalKey<FormState>, not a GlobalKey<LoginFormState>.
    final GlobalKey<FormFieldState<String>> _emailFieldKey = GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

    // Summary: Models and validators
    LoginModel _loginModel = new LoginModel();
    TextFieldValidators txtFieldValidators = new TextFieldValidators();


    // Summary: function is used to validate the fields at client side.
    void validateOnFieldSubmitted(String value, String field) {

        // Flag = 0 if form not submitted and form =1 when form has been submitted.
        var boolValidate = this.txtFieldValidators.validateFieldValue(value, field);
        switch(field){
            case "email":{
                if(flag == 0 && boolValidate != null){
                    _emailFieldKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtEmail);
                } else if(flag == 0 && boolValidate == null){
                    _emailFieldKey.currentState.validate();
                    _loginModel.email = _emailFieldKey.currentState.value;
                    FocusScope.of(context).requestFocus(txtPassword);
                }
                if(flag == 1 && boolValidate != null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtEmail);
                } else if(flag == 1 && boolValidate == null){
                    _formKey.currentState.validate();
                    _loginModel.email = _emailFieldKey.currentState.value;
                    FocusScope.of(context).requestFocus(txtPassword);
                }
            }
            break;
            case "password": {
                if(flag == 0 && boolValidate != null){
                    _passwordFieldKey.currentState.validate();
                }
                else if(flag == 0 && boolValidate == null){
                    _loginModel.password = _passwordFieldKey.currentState.value;
                }
                if(flag == 1 && boolValidate != null) {
                    _formKey.currentState.validate();
                }
                else if(flag == 1 && boolValidate == null){
                    _loginModel.password = _passwordFieldKey.currentState.value;
                }
            }
            break;
        }
    }

    // Summary provides that inwhich format password must be
    void passwordInfo() {
        InformationDialog.passwordInformation(context);
    }

    // Summary: this function is called when we submit the form.
    void submitForm() {

        flag =1;
        if(_formKey.currentState.validate() == false){
            setState(() {
                heightOfLoginContainer += 20;
                marginFromTopLogin += 20;
            });
        }
        // Summary: Check Internet connection.
        Connectivity.networkConnection(context).then((response) {

            if (_formKey.currentState.validate()) {

                // Summary: This save() will trigger onSaved of each formField.
                _formKey.currentState.save();

                // Summary: show alert dialog with progressbar
                CustomDialog.showDialogBox(context);

                // Summary: fetch the response from the Future async API task.
                ApiCallsInAuthentication.loginApi(_loginModel, context).then((LoginAPIResponse resValue){
                    if(resValue.success){

                        // Summary: Dispatch the action.
                        this.store.dispatch(LoginAction(loginAPIActionResponse: resValue));
                        _formKey.currentState.reset();

                        // Summary: hide progressbar.
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/dashboard');
                    } else{

                        // Summary: hide progressbar.
                        Navigator.of(context).pop();
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text(resValue.message)));
                    }
                });
            }
        }).catchError((error){
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Internet not Connected")));
        });

    }

//    void showInSnackBar(String value) {
//        FocusScope.of(context).requestFocus(new FocusNode());
//        _scaffoldKey.currentState?.removeCurrentSnackBar();
//        _scaffoldKey.currentState.showSnackBar(new SnackBar(
//            content: new Text(
//                value,
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 16.0,
//                    fontFamily: "WorkSansSemiBold"),
//            ),
//            backgroundColor: Colors.blue,
//            duration: Duration(seconds: 3),
//        ));
//    }

    // Summary: Will create tables in the SQLite database.
    createTablesInDatabase(){

        CreateTables.createTableStatement('Posts');
        CreateTables.createTableStatement('Comments');
    }

    @override
    Widget build(BuildContext context) {

        return StoreConnector<AppState, ListProps>(
            converter: (Store<AppState> store) {
                this.store = store;
                this.testRedux = store.state.reduxSetup;
                return ListProps().mapStateToProps(store);
            },
            onInitialBuild: (props){
                props.posts();
                props.comments();
            },
            builder: (BuildContext context, props) {
                createTablesInDatabase();
                // Summary: Build a Form widget using the _formKey created above.
                return Form(
                    key: _formKey,
                    child: Container(
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
                                                width: MediaQuery.of(context).size.width * .8,
//                                                300.0,
                                                height: heightOfLoginContainer,
                                                child: Column(
                                                    children: <Widget>[
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                            child: TextFormField(
                                                                    focusNode: txtEmail,
                                                                    key: _emailFieldKey,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder.none,
                                                                        icon: Icon(
                                                                            FontAwesomeIcons.envelope,
                                                                            color: Colors.black,
                                                                            size: 22.0,
                                                                        ),
                                                                        hintText: "Email Address",
                                                                        hintStyle: TextStyle(
                                                                            fontFamily: "WorkSansSemiBold",
                                                                            fontSize: 17.0
                                                                        ),
                                                                    ),
                                                                    style: TextStyle(
                                                                        fontFamily: "WorkSansSemiBold",
                                                                        fontSize: 16.0,
                                                                        color: Colors.black
                                                                    ),
                                                                    onFieldSubmitted:(value) => this.validateOnFieldSubmitted(value, 'email'),
                                                                    onSaved: (value) => _loginModel.email = value,
                                                                    validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
                                                                ),
                                                        ),
                                                        Container(
                                                            width: MediaQuery.of(context).size.width * .7,
                                                            height: 1.0,
                                                            color: Colors.grey[400],
                                                        ),
                                                        Padding(
                                                            padding: EdgeInsets.only(
                                                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                            child: TextFormField(
                                                                    focusNode: txtPassword,
                                                                    key: _passwordFieldKey,
                                                                    obscureText: true,
                                                                    decoration: InputDecoration(
                                                                        border: InputBorder.none,
                                                                        icon: Icon(
                                                                            FontAwesomeIcons.lock,
                                                                            size: 22.0,
                                                                            color: Colors.black,
                                                                        ),
                                                                        hintText: "Password",
                                                                        hintStyle: TextStyle(
                                                                            fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                                                                        suffixIcon: GestureDetector(
                                                                            onTap:() => this.passwordInfo(),
                                                                            child: Icon(
                                                                                FontAwesomeIcons.eye,
                                                                                size: 15.0,
                                                                                color: Colors.black,
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    style: TextStyle(
                                                                        fontFamily: "WorkSansSemiBold",
                                                                        fontSize: 16.0,
                                                                        color: Colors.black
                                                                    ),
                                                                    onFieldSubmitted: (value) => this.validateOnFieldSubmitted(value, 'password'),
                                                                    onSaved: (value) => _loginModel.password = value,
                                                                    validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
                                                                ),
                                                            ),
                                                            Container(
                                                                width: MediaQuery.of(context).size.width * .7,
                                                                height: 1.0,
                                                                color: Colors.grey[400],
                                                            )
                                                    ],
                                                ),
                                            ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: marginFromTopLogin),
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
                                                        "LOGIN",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 25.0,
                                                            fontFamily: "WorkSansBold"),
                                                    ),
                                                ),
                                                onPressed: () => this.submitForm()
                                            ),
                                        ),
                                    ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                fontFamily: "WorkSansMedium"),
                                        )),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                            Container(
                                                decoration: BoxDecoration(
                                                    gradient: new LinearGradient(
                                                        colors: [
                                                            Colors.white10,
                                                            Colors.white,
                                                        ],
                                                        begin: const FractionalOffset(0.0, 0.0),
                                                        end: const FractionalOffset(1.0, 1.0),
                                                        stops: [0.0, 1.0],
                                                        tileMode: TileMode.clamp),
                                                ),
                                                width: 100.0,
                                                height: 1.0,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                                child: Text(
                                                    "Or",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontFamily: "WorkSansMedium"),
                                                ),
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    gradient: new LinearGradient(
                                                        colors: [
                                                            Colors.white,
                                                            Colors.white10,
                                                        ],
                                                        begin: const FractionalOffset(0.0, 0.0),
                                                        end: const FractionalOffset(1.0, 1.0),
                                                        stops: [0.0, 1.0],
                                                        tileMode: TileMode.clamp),
                                                ),
                                                width: 100.0,
                                                height: 1.0,
                                            ),
                                        ],
                                    ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(top: 10.0, right: 40.0),
                                            child: GestureDetector(
                                                //                                            onTap: () => showInSnackBar("Facebook button pressed"),
                                                child: Container(
                                                    padding: const EdgeInsets.all(15.0),
                                                    decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                    ),
                                                    child: new Icon(
                                                        FontAwesomeIcons.facebookF,
                                                        color: Color(0xFF0084ff),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: GestureDetector(
                                                //                                            onTap: () => showInSnackBar("Google button pressed"),
                                                child: Container(
                                                    padding: const EdgeInsets.all(15.0),
                                                    decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                    ),
                                                    child: new Icon(
                                                        FontAwesomeIcons.google,
                                                        color: Color(0xFF0084ff),
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    )
                );
            },
        );

    }
}



