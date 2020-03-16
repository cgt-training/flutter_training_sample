import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_training_app/actions/login_actions.dart';
import 'package:flutter_training_app/db_operations/create_tables.dart';
import 'package:flutter_training_app/screens/screen_props/list_props.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

// ApiCaliing
import 'package:flutter_training_app/api_calling/authentication.dart';

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';

// Model
import 'package:flutter_training_app/models/login.dart';
import 'package:flutter_training_app/models/redux/redux_models.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// UI Elements
import 'package:flutter_training_app/ui_elements/customDialog.dart';
import 'package:flutter_training_app/ui_elements/information_Dialog.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';
import 'package:flutter_training_app/util/connectivity.dart';

// Summary: This class holds data related to the login form and also maintains the state of data.
class LoginFormState extends State<LoginForm> {

    // Summary: local variables
    int flag =0;
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
                    child: Center(
                        child:Container(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                                children: <Widget>[
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Enter Email'
                                        ),
                                        focusNode: txtEmail,
                                        key: _emailFieldKey,
                                        keyboardType: TextInputType.emailAddress,
                                        onFieldSubmitted:(value) => this.validateOnFieldSubmitted(value, 'email'),
                                        onSaved: (value) => _loginModel.email = value,
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
                                    ),
                                    TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Enter Password',
                                            suffixIcon:  IconButton(
                                                icon: Icon(Icons.info),
                                                iconSize: 25,
                                                onPressed: (){
                                                    this.passwordInfo();
                                                },
                                            )
                                        ),
                                        key: _passwordFieldKey,
                                        focusNode: txtPassword,
                                        obscureText: true,
                                        onFieldSubmitted: (value) => this.validateOnFieldSubmitted(value, 'password'),
                                        onSaved: (value) => _loginModel.password = value,
                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: ButtonTheme(
                                            minWidth: 300,
                                            height:50,
                                            child: FlatButton(
                                                color: Colors.pink[500],
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,

                                                onPressed: () => this.submitForm(),
                                                child: Text(
                                                    "Login",
                                                    style: TextStyle(fontSize: 20.0),
                                                ),
                                            ),
                                        ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: ButtonTheme(
                                            minWidth: 300,
                                            height: 50,
                                            child: FlatButton(
                                                color: Colors.pink[500],
                                                textColor: Colors.white,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(8.0),
                                                splashColor: Colors.blueAccent,
                                                onPressed: () {
                                                    _formKey.currentState.reset();
                                                    Navigator.pushNamed(context, '/registration');
                                                },
                                                child: Text(
                                                    'Registration',
                                                    style: TextStyle(fontSize: 20.0),
                                                )
                                            ),
                                        ),
                                    )
                                ],
                            ),
                        )
                    ),
                );
            },

        );

    }
}