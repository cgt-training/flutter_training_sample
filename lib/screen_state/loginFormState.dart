import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ApiCaliing
import 'package:flutter_training_app/api_calling/authentication.dart';

// Dependency
import 'package:http/http.dart' as http;

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';

// Model
import 'package:flutter_training_app/models/login.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';


// Summary: This class holds data related to the login form and also maintains the state of data.
class LoginFormState extends State<LoginForm> {

  // Summary: local variables
  int flag =0;

  // Summary: Form variables
  FocusNode txtEmail = new FocusNode();
  FocusNode txtPassword = new FocusNode();
  final _formKey = GlobalKey<FormState>(); // Note: This is a GlobalKey<FormState>, not a GlobalKey<LoginFormState>.
  final GlobalKey<FormFieldState<String>> _emailFieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  // Summary: Models and validators
  LoginModel _loginModel = new LoginModel();
  TextFieldValidators txtFieldValidators = new TextFieldValidators();

  // Summary: this function is called when we submit the form.
  void submitForm(){
    flag =1;

    if (_formKey.currentState.validate()) {

      // Summary: This save() will trigger onSaved of each formField.
      _formKey.currentState.save();

       // Summary: fetch the response from the Future async API task.
       ApiCallsInAuthentication.loginApi(_loginModel, context).then((LoginAPIResponse resValue){
          if(resValue.success){
            Navigator.pushNamed(context, '/dashboard');
          }else{
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(resValue.message)));
          }
      });
    }
  }

  void validateOnFieldSubmitted(String value, String field) {

//    var validate = this.txtFieldValidators.validateFieldValue(value, field);

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
//          FocusScope.of(context).requestFocus(txtPassword);
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
//    print(_passwordFieldKey.currentState.validate());

//    if(validate == null){
//      _formKey.currentState.validate();
//      FocusScope.of(context).requestFocus(txtPassword);
//    }else{
//      FocusScope.of(context).requestFocus(txtEmail);
//    }
  }

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
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
                        decoration: const InputDecoration(
                            labelText: 'Enter Password'
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
  }
}