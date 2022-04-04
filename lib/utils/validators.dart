import 'package:email_validator/email_validator.dart';

validateEmail(email) {
  bool emailValid = EmailValidator.validate(email);
  return emailValid;
}

checkEmptyValue(value) {
  if (value == null) {
    return '';
  }
  return value;
}
