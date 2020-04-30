import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'new_user_form.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepository get _userRepository => widget.userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
      panel: Center(
        child: NewUserForm(userRepository: _userRepository),
      ),
      body: LoginForm(userRepository: _userRepository),
      header: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 5.0, color: Colors.white),
            ),
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                width: 40.0,
                height: 5.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
            ),
          ),
          Text("Create Account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
        ]),
      ),
    ));
  }
}
