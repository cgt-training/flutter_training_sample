import 'package:flutter/material.dart';

// Form
import 'package:flutter_training_app/Forms/registrationForm.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

class RegistrationFormState extends State<RegistrationForm>{

  final _formKey = GlobalKey<FormState>();
  TextFieldValidators txtFieldValidators =new TextFieldValidators();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                                labelText: 'Enter Your Name'
                            ),
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'name')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Username'
                            ),
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'username')
                        ),
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

                                    onPressed: (){

                                    },
//                                    => this.submitForm(),
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