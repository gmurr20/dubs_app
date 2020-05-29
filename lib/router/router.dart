import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/home/home_page.dart';
import 'package:dubs_app/screen/login/login_page.dart';
import 'package:dubs_app/screen/set_user_data/set_user_data_page.dart';
import 'package:dubs_app/screen/verify_user/verify_user_page.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/screen/template_screen/share_form.dart';

const String loginRoute = '/';
const String testRoute = '/adfadsfasdfasdfsadfsad';
const String homeRoute = '/home';
const String verifyUserRoute = "/verifyUser";
const String addUsernameRoute = "/addUsername";

class Router {
  static UserRepository userRepo = UserRepository();
  static User currentUser;
  static final _logger = getLogger("Router");
  static BuildContext context;
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return _createNewPage(LoginPage(userRepository: userRepo));
      case verifyUserRoute:
        return _createNewPage(
            VerifyUserPage(userRepository: userRepo, user: settings.arguments));
      case homeRoute:
        return _createNewPage(HomePage());
      case addUsernameRoute:
        return _createNewPage(SetUserDataPage(userRepository: userRepo));
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

  static Future<bool> _onWillPop() async {
    _logger.v("_onWillPop- activated");
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to logout'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () async {
                  _logger.v("_onWillPop- pressed Yes. Logging out");
                  await userRepo.logout();
                  Navigator.of(context).pushNamed(loginRoute);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  static Route<dynamic> _createNewPage(Widget newPage) {
    return MaterialPageRoute(builder: (ctx) {
      context = ctx;
      return WillPopScope(onWillPop: _onWillPop, child: newPage);
    });
  }
}
