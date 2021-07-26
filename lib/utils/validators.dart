String emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp emailRegExp = RegExp(emailPattern);

String phoneNumberpattern = r'(^0[19][0-9]{8}$)';
RegExp phoneNumberRegExp = RegExp(phoneNumberpattern);

String amountPattern = r'(^[0-9]+$)';
RegExp amountRegExp = RegExp(amountPattern);

String expiryDatePattern = r'(^[0-9]{4}$)';
RegExp expiryDateRegExp = RegExp(expiryDatePattern);

bool isEmailValid(String email) {
  return emailRegExp.hasMatch(email);
}

bool isPhoneNumbervalid(String phoneNumber) {
  return phoneNumberRegExp.hasMatch(phoneNumber);
}

bool isAmountValid(String amount) {
  return amountRegExp.hasMatch(amount);
}

bool isExpiryDateValid(String expiryDate) {
  return expiryDateRegExp.hasMatch(expiryDate);
}

////
///
String emailValidator(String value) {
  if (value == null || value.isEmpty) return "Please enter your email";
  if (isEmailValid(value) == false) return "Invalid email";
  return null;
}

String passwordValidator(String value) {
  if (value == null || value.isEmpty) return "Please enter your password";
  return null;
}

String usernameValidator(String value) {
  if (value == null || value.isEmpty) return "Please enter your username";
  return null;
}
