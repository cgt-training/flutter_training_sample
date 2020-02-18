import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

// FormField
import 'package:passwordfield/passwordfield.dart';

// Form
import 'package:flutter_training_app/Forms/loginForm.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';



// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  // Note: This is a GlobalKey<FormState>, not a GlobalKey<LoginFormState>.
  final _formKey = GlobalKey<FormState>();

  TextFieldValidators txtFieldValidators = new TextFieldValidators();

  // Summary: this function is called when we click on login button.
  void submitForm(){
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Enter Email'
                        ),
                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Enter Password'
                        ),
                        obscureText: true,
                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ButtonTheme(
                          minWidth: 120,
                          height:30,
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
                          minWidth: 120,
                          height: 30,
                          child: FlatButton(
                              color: Colors.pink[500],
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () {
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