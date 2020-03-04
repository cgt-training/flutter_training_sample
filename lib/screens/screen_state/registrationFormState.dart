import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//API Calling
import 'package:flutter_training_app/api_calling/authentication.dart';

// Dependency
import 'package:image_picker/image_picker.dart';

// Form
import 'package:flutter_training_app/screens/forms/registrationForm.dart';

// Model
import 'package:flutter_training_app/models/register.dart';

//UI Elements
import 'package:flutter_training_app/ui_elements/information_Dialog.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

class RegistrationFormState extends State<RegistrationForm>{

//    Local variables
    File _pickedImage;
    int flag = 0;

    // Form variables
    final _formKey = GlobalKey<FormState>();
    FocusNode txtName = new FocusNode();
    FocusNode txtEmail = new FocusNode();
    FocusNode txtUserName = new FocusNode();
    FocusNode txtPassword = new FocusNode();

    // Models and Validator
    TextFieldValidators txtFieldValidators =new TextFieldValidators();
    RegisterModel _registerModel =  new RegisterModel();

    // Summary: This function is called when form is submitted.
    void submitForm(){
        flag = 1;
        if(_formKey.currentState.validate()) {
            flag =0;
            if(_pickedImage == null) {

                this._pickImage();
                return;
            }else {

                _formKey.currentState.save();
                // Summary: Call the service to fire api and return response from network.
                ApiCallsInAuthentication.registerApi(_registerModel, context).then((response) => {

                    if(response.message == "success"){
                        Navigator.pushNamed(context, '/dashboard')
                    }else{
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text(response.message)))
                    }
                });
            }
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing data')));
        }
    }

    // Summary: Function for image picker.
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

            print(file.path);

            _registerModel.profileImageData = file.path;

            if(file != null) {
                setState(() => _pickedImage = file);
            }
        }
    }

    // Summary: This function is called when and textfield submit the value from keyboard
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

    // Summary: Fired when password info button is pressed.
    void passwordInfo(){
        InformationDialog.passwordInformation(context);
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
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'name')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Your Username'
                            ),
                            focusNode: txtUserName,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'username'),
                            onSaved: (value) => _registerModel.username = value,
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'username')
                        ),
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter Email'
                            ),
                            focusNode: txtEmail,
                            keyboardType: TextInputType.emailAddress,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'email'),
                            onSaved: (value) => _registerModel.email = value,
                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Enter Password',
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.info),
                                    iconSize: 25,
                                    onPressed: (){
                                        this.passwordInfo();
                                    },
                                )
                            ),
                            focusNode: txtPassword,
                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'password'),
                            obscureText: true,
                            onSaved: (value) => _registerModel.password = value,
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