//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Dependency Elements
import 'package:image_picker/image_picker.dart';

// Form
import 'package:flutter_training_app/Forms/registrationForm.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

class RegistrationFormState extends State<RegistrationForm>{

    File _pickedImage;
    int flag = 0;
    final _formKey = GlobalKey<FormState>();
    FocusNode txtName = new FocusNode();
    FocusNode txtEmail = new FocusNode();
    FocusNode txtUserName = new FocusNode();
    FocusNode txtPassword = new FocusNode();

    TextFieldValidators txtFieldValidators =new TextFieldValidators();

    void submitForm(){
        flag = 1;
        if(_formKey.currentState.validate()) {
            flag =0;
            if(_pickedImage == null) {
                this._pickImage();
                return;
            }
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing data')));
        }
    }

    void _pickImage() async {
        final imageSource = await showDialog<ImageSource>(
            context: context,
            builder: (context) =>
                AlertDialog(
                    title: Text("Select the image source"),
                    actions: <Widget>[
                        MaterialButton(
                            child: Text("Camera"),
                            onPressed: () => Navigator.pop(context, ImageSource.camera),
                        ),
                        MaterialButton(
                            child: Text("Gallery"),
                            onPressed: () => Navigator.pop(context, ImageSource.gallery),
                        )
                    ],
                )
        );

        if(imageSource != null) {
            final file = await ImagePicker.pickImage(source: imageSource);
            if(file != null) {
                setState(() => _pickedImage = file as File);
            }
        }
    }

    onFieldSubmitCustom(String Value, String field){

        var boolValidate = this.txtFieldValidators.validateFieldValue(Value, field);
        switch(field){
            case "name":{

                if(flag == 1 && boolValidate != null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtName);
                } else if(flag == 1 && boolValidate == null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtUserName);
                }else{
                    FocusScope.of(context).requestFocus(txtUserName);
                }
            }
            break;
            case "username":{
                if(flag == 1 && boolValidate != null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtUserName);
                } else if(flag == 1 && boolValidate == null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtEmail);
                }else{
                    FocusScope.of(context).requestFocus(txtEmail);
                }
            }
            break;
            case "email":{

                if(flag == 1 && boolValidate != null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtEmail);
                } else if(flag == 1 && boolValidate == null){
                    _formKey.currentState.validate();
                    FocusScope.of(context).requestFocus(txtPassword);
                }else{
                    FocusScope.of(context).requestFocus(txtPassword);
                }
            }
            break;
            case "password":{
                if(flag == 1 && boolValidate != null){
                    _formKey.currentState.validate();
                }
            }
            break;
        }
    }

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

                        Center(
                            child: Column(
                                children: <Widget>[
                                    _pickedImage == null ? Text("No image selected"): Image(height: 100, width: 100, image: FileImage(_pickedImage)),
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
                                                onPressed:() => this._pickImage(),
                                                child: Text(
                                                    'Pick Image',
                                                    style: TextStyle(fontSize: 20.0),
                                                )
                                            ),
                                        ),
                                    )
                                ],
                            )
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Name'
                            ),
                            focusNode: txtName,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'name'),
//                                FocusScope.of(context).requestFocus(txtUserName),
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'name')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Username'
                            ),
                            focusNode: txtUserName,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'username'),
                                //FocusScope.of(context).requestFocus(txtEmail),
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'username')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Email'
                            ),
                            focusNode: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'email'),
                                //FocusScope.of(context).requestFocus(txtPassword),
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Password'
                            ),
                            focusNode: txtPassword,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'password'),
                            obscureText: true,
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonTheme(
                                minWidth: 300,
                                height:30,
                                child: FlatButton(
                                    color: Colors.pink[500],
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    padding: EdgeInsets.all(8.0),
                                    splashColor: Colors.blueAccent,
                                    onPressed: ()=> this.submitForm(),
                                    child: Text(
                                        "Register",
                                        style: TextStyle(fontSize: 20.0),
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            )
        ),
    );
  }

}