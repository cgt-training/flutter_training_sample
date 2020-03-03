import 'package:flutter/material.dart';

import 'package:flutter_training_app/screens/forms/registrationForm.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        title: Text('Registration'),
        elevation: 0,
      ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: RegistrationForm(),
          ),
        )
    );
  }
}
