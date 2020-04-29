class TextValidator {
  static bool isValidEmail(String emailAddress) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailAddress);
  }

  static String passwordCredentials =
      "Password must have 1 uppercase character, 1 lowercase character, " +
          "1 numeric character, and 1 special character (!,@,\#,\$,\&,*,~)";

  static bool isValidPassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }
}
