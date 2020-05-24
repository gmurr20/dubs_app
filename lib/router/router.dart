import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/home/home_page.dart';
import 'package:dubs_app/screen/login/login_page.dart';
import 'package:dubs_app/screen/template_screen/template_screen.dart';
import 'package:dubs_app/screen/verify_user/verify_user_page.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/screen/template_screen/share_form.dart';

const String loginRoute = '/';
const String testRoute = '/adfadsfasdfasdfsadfsad';
const String homeRoute = '/home';
const String verifyUserRoute = "/verifyUser";

class Router {
  static UserRepository userRepo = UserRepository();
  static final _logger = getLogger("Router");
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return _createNewPage(LoginPage(userRepository: userRepo));
      case verifyUserRoute:
        return _createNewPage(VerifyUserPage(userRepository: userRepo));
      case homeRoute:
        return _createNewPage(HomePage());
      case testRoute:
        return _createNewPage(ShareForm());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static Route<dynamic> _createNewPage(Widget newPage) {
    return MaterialPageRoute(
      builder: (_) => WillPopScope(
          onWillPop: () async {
            _logger.v("onWillPop- caught the back button action");
            return true;
          },
          child: newPage),
    );
  }
}
