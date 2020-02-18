// Summary: This class is used to validate different fields of form.

class TextFieldValidators{

  String validateFieldValue(String value, String fieldName) {

    if (value.isEmpty) {
      return 'Please enter value for $fieldName' ;
    }

    switch(fieldName){
      case "name": {
        String nameMessage = this.validateNameField(value);
        return nameMessage;
      }
      break;
      case "email": {
        String emailMessage = this.validateEmailField(value);
        return emailMessage;
      }
      break;
      case "password":{
        String passwordMessage = this.validatePasswordField(value);
        return passwordMessage;
      }
      break;
    }
    return null;
  }

  // Summary: Function used to validate only alphabets for name field.
  String validateNameField(String value){

    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter alphabates only for name field';
    }
  }

  // Summary: Function used to validate email format.
  String validateEmailField(String value){

    final emailExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailExp.hasMatch(value)) {
      return 'Please enter email in correct format';
    }
  }

  // Summary: Function used to validate password format to check number, capital & small letter and special character.
  String validatePasswordField(String value){

    final passwordExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if(value.length <= 7){
      return 'Password should be greater than 7 characters and must contain number, both capital & small letter and special character';
    }
    if (!passwordExp.hasMatch(value)) {
      return 'Password must contain number, both capital & small letter and special character';
    }
  }
}

