import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/login/login_page.dart';
import 'package:flutter/material.dart';

const String loginRoute = '/';
const String newUserRoute = '/new_user';
const String homeRoute = '/home';

class Router {
  static UserRepository userRepo = UserRepository();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginPage(userRepository: userRepo));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
