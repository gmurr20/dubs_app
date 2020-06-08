const String EMPTY_EMAIL = "Enter your email address";
const String EMPTY_PASSWORD = "Enter your password";
const String EMPTY_USERNAME = "Enter a username";
const String INVALID_EMAIL_FORMAT =
    "Enter a valid email address user@example.com";

String checkAndPrint(String msg) {
  if (msg != null) {
    return msg;
  }
  return "null";
}
