//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';

// Dependency Elements
import 'package:image_picker/image_picker.dart';

// Form
import 'package:flutter_training_app/Forms/registrationForm.dart';

// Validators
import 'package:flutter_training_app/validators/textFieldValidators.dart';

class RegistrationFormState extends State<RegistrationForm>{

    File _pickedImage;
    final _formKey = GlobalKey<FormState>();
    TextFieldValidators txtFieldValidators =new TextFieldValidators();

    void submitForm(){

        if(_pickedImage == null) {
            this._pickImage();
        }
        if(_formKey.currentState.validate()) {
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