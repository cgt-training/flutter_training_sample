import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//API Calling
import 'package:flutter_training_app/api_calling/authentication.dart';

// Dependency
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Form
import 'package:flutter_training_app/Forms/registrationForm.dart';

// Model
import 'package:flutter_training_app/models/register.dart';

//UI Elements
import 'package:flutter_training_app/ui_elements/customDialog.dart';
import 'package:flutter_training_app/ui_elements/information_Dialog.dart';

// Util
import 'package:flutter_training_app/util/style/theme.dart' as Theme;

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

class RegistrationFormState extends State<RegistrationForm>{

//    Local variables
    File _pickedImage;
    int flag = 0;
    double heightOfRegistrationForm = 450.0;
    double marginFromTop = 430.0;

    double heightOfScroll = 775.0;
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
        if(_formKey.currentState.validate() == false){
            setState(() {
                heightOfRegistrationForm += 90;
                marginFromTop += 90;
            });
        }
        _registerModel.profileImageData ;
        if(_formKey.currentState.validate()) {
            flag =0;
//            if(_pickedImage == null) {
//
//                this._pickImage();
//                return;
//            }else {

                _formKey.currentState.save();
                CustomDialog.showDialogBox(context);
                // Summary: Call the service to fire api and return response from network.
                ApiCallsInAuthentication.registerApi(_registerModel, context).then((response) => {

                    showResponse(response.message, context)
                });
//            }
        }
    }

    // Summary: Will Show the response received from API.
    void showResponse(String response, BuildContext context){
        print("void showResponse(String response, BuildContext context)");
        if(response == "User Already Exist"){
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(response)));
        }else{
            _formKey.currentState.reset();
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(response)));
//            Navigator.pushNamed(context, '/login');
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
                                        height: heightOfRegistrationForm,
                                        child: Column(
                                            children: <Widget>[

                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                                                    child: TextFormField(
                                                        focusNode: txtName,
                                                        onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'name'),
                                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'name'),
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
                                                                fontFamily: "WorkSansSemiBold",
                                                                fontSize: 16.0
                                                            ),
                                                        ),
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
                                                        focusNode: txtUserName,
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
                                                            hintText: "User Name",
                                                            hintStyle: TextStyle(
                                                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                                                        ),
                                                        onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'username'),
                                                        onSaved: (value) => _registerModel.username = value,
                                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'username')
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
                                                        focusNode: txtEmail,
                                                        keyboardType: TextInputType.emailAddress,
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
                                                        onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'email'),
                                                        onSaved: (value) => _registerModel.email = value,
                                                        style: TextStyle(
                                                            fontFamily: "WorkSansSemiBold",
                                                            fontSize: 16.0,
                                                            color: Colors.black),
                                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email'),
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
                                                                onTap: () => this.passwordInfo(),
                                                                child: Icon(
                                                                    FontAwesomeIcons.eye,
                                                                    size: 15.0,
                                                                    color: Colors.black,
                                                                ),
                                                            ),
                                                        ),
                                                        focusNode: txtPassword,
                                                        onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'password'),
                                                        obscureText: true,
                                                        onSaved: (value) => _registerModel.password = value,
                                                        style: TextStyle(
                                                            fontFamily: "WorkSansSemiBold",
                                                            fontSize: 16.0,
                                                            color: Colors.black
                                                        ),
                                                        validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
                                                    ),
                                                ),
                                                Container(
                                                    width: MediaQuery.of(context).size.width * .7,
                                                    height: 1.0,
                                                    color: Colors.grey[400],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                                top: 20.0,
                                                                bottom: 20.0,
                                                                left: 25.0,
                                                                right: 25.0
                                                             ),
                                                    child: TextField(
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
    //                                                            onTap: _toggleSignupConfirm,
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
                                    margin: EdgeInsets.only(top: marginFromTop),
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
                                        onPressed: () => this.submitForm(),
    //                                        showInSnackBar("SignUp button pressed")),
                                    ),
                                )
                            ],
                        ),
                    ],
                ),
            ),

//            child:Container(
//                margin: EdgeInsets.all(20.0),
//                child: Column(
//                    // crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//
//                        Center(
//                            child: Column(
//                                children: <Widget>[
//                                    _pickedImage == null ? Text("No image selected"): Image(height: 100, width: 100, image: FileImage(_pickedImage)),
//                                    Container(
//                                        margin: EdgeInsets.only(top: 20),
//                                        child: ButtonTheme(
//                                            minWidth: 120,
//                                            height: 30,
//                                            child: FlatButton(
//                                                color: Colors.pink[500],
//                                                textColor: Colors.white,
//                                                disabledColor: Colors.grey,
//                                                disabledTextColor: Colors.black,
//                                                padding: EdgeInsets.all(8.0),
//                                                splashColor: Colors.blueAccent,
//                                                onPressed:() => this._pickImage(),
//                                                child: Text(
//                                                    'Pick Image',
//                                                    style: TextStyle(fontSize: 20.0),
//                                                )
//                                            ),
//                                        ),
//                                    )
//                                ],
//                            )
//                        ),
//                        TextFormField(
//                            decoration: const InputDecoration(
//                                labelText: 'Enter Your Name'
//                            ),
//                            focusNode: txtName,
//                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'name'),
//                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'name')
//                        ),
//                        TextFormField(
//                            decoration: const InputDecoration(
//                                labelText: 'Enter Your Username'
//                            ),
//                            focusNode: txtUserName,
//                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'username'),
//                            onSaved: (value) => _registerModel.username = value,
//                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'username')
//                        ),
//                        TextFormField(
//                            decoration: const InputDecoration(
//                                labelText: 'Enter Email'
//                            ),
//                            focusNode: txtEmail,
//                            keyboardType: TextInputType.emailAddress,
//                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'email'),
//                            onSaved: (value) => _registerModel.email = value,
//                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'email')
//                        ),
//                        TextFormField(
//                            decoration: InputDecoration(
//                                labelText: 'Enter Password',
//                                suffixIcon: IconButton(
//                                    icon: Icon(Icons.info),
//                                    iconSize: 25,
//                                    onPressed: (){
//                                        this.passwordInfo();
//                                    },
//                                )
//                            ),
//                            focusNode: txtPassword,
//                            onFieldSubmitted: (value) => this.onFieldSubmitCustom(value, 'password'),
//                            obscureText: true,
//                            onSaved: (value) => _registerModel.password = value,
//                            validator: (value) => this.txtFieldValidators.validateFieldValue(value, 'password')
//                        ),
//                        Container(
//                            margin: EdgeInsets.only(top: 20),
//                            child: ButtonTheme(
//                                minWidth: 300,
//                                height:30,
//                                child: FlatButton(
//                                    color: Colors.pink[500],
//                                    textColor: Colors.white,
//                                    disabledColor: Colors.grey,
//                                    disabledTextColor: Colors.black,
//                                    padding: EdgeInsets.all(8.0),
//                                    splashColor: Colors.blueAccent,
//                                    onPressed: ()=> this.submitForm(),
//                                    child: Text(
//                                        "Register",
//                                        style: TextStyle(fontSize: 20.0),
//                                    ),
//                                ),
//                            ),
//                        ),
//                    ],
//                ),
//            )
        );

    }

    @override
    void dispose() {
        // TODO: implement dispose
        super.dispose();
    }
}