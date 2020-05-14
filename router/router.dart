import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/home/home_page.dart';
import 'package:dubs_app/screen/login/login_page.dart';
import 'package:dubs_app/screen/template_screen/template_screen.dart';
import 'package:dubs_app/screen/verify_user/verify_user_page.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/screen/template_screen/share_form.dart';
import 'package:dubs_app/screen/template_screen/XD_InboxScreen.dart';
import 'package:dubs_app/screen/template_screen/XD_InboxScreenMenuExpanded.dart';
import 'package:dubs_app/screen/template_screen/XD_HomeScreenNewUser.dart';

const String loginRoute = '/';
const String testRoute = '/adfadsfasdfasdfsadfsad';
const String homeRoute = '/home';
const String verifyUserRoute = "/verifyUser";

class Router {
  static UserRepository userRepo = UserRepository();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginPage(userRepository: userRepo));
      case verifyUserRoute:
        return MaterialPageRoute(
            builder: (_) => VerifyUserPage(userRepository: userRepo));
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case testRoute:
        return MaterialPageRoute(builder: (_) => XD_HomeScreenNewUser());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
