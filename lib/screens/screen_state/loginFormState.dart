import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_redux/flutter_redux.dart';

// Form
import 'package:flutter_training_app/screens/forms/loginForm.dart';

// Model
import 'package:flutter_training_app/models/login.dart';
import 'package:flutter_training_app/models/redux/redux_models.dart';

// Response Model
import 'package:flutter_training_app/response_model/loginResponse.dart';

// Screens-> Screen Props
import 'package:flutter_training_app/screens/screen_props/login_screen_props.dart';

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
    LoginAPIResponse loginAPIResponseState;
    LoginScreenProps screenProps;

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

    // Summary provides that in which format password must be
    void passwordInfo(){
        InformationDialog.passwordInformation(context);
    }

    // Summary: this function is called when we submit the form.
    void submitForm(){
        flag =1;
        // Summary: Check Internet connection
        Connectivity.networkConnection(context).then((response){
            if (_formKey.currentState.validate()) {
                // Summary: This save() will trigger onSaved of each formField.
                _formKey.currentState.save();
                // Summary: show alert dialog with progressbar
                CustomDialog.showDialogBox(context);
                // Summary: Call the action loginAPICall
                this.screenProps.loginAPICall(_loginModel);

            }
        }).catchError((error){
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Internet not Connected")));
        });

    }

    void handleInitialBuild(LoginScreenProps props){
        print("handleInitialBuild");
        this.screenProps = props;
    }

    void loginResponse(LoginScreenProps props){

    }

    @override
    Widget build(BuildContext context) {

        return StoreConnector<AppState, LoginScreenProps>(
            converter: (store) {
                return mapStateToProps(store);
            },
            onInitialBuild: (props){

                this.handleInitialBuild(props);
            },
            builder: (context, props) {
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
                                    ),
                                ],
                            ),
                        )
                    ),
                );
            },// Builder
            onDidChange: (LoginScreenProps props){
                print("onDidChange: (LoginScreenProps props){");
                if(props.apiResponse != null){
                    if(props.apiResponse.loginAPIResponseState.loginAPIResponseState != null) {
                        print("this.screenProps.apiResponse.onDidChange");
                        print(props.apiResponse.loginAPIResponseState.loginAPIResponseState.success);
                        if(props.apiResponse.loginAPIResponseState.loginAPIResponseState.success){
                            _formKey.currentState.reset();
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, '/dashboard');
                        }else{
                            // Summary: hide progressbar.
                            Navigator.of(context).pop();
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(props.apiResponse.loginAPIResponseState.loginAPIResponseState.message)));
                        }
                    } // Outer If
                } // Parent If
            },
        );
    }

    @override
    void didChangeDependencies() {
        // TODO: implement didChangeDependencies
        super.didChangeDependencies();
        print("super.didChangeDependencies()");
    }
    @override
    void didUpdateWidget(LoginForm oldWidget) {
        // TODO: implement didUpdateWidget
        super.didUpdateWidget(oldWidget);
        print("***************didUpdateWidget******************");
    }
}