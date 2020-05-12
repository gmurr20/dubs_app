import 'dart:async';

import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_bloc.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_events.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_states.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyUserPage extends StatefulWidget {
  final UserRepository userRepository;

  VerifyUserPage({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<VerifyUserPage> createState() => _VerifyUserPageState();
}

class _VerifyUserPageState extends State<VerifyUserPage> {
  VerifyUserBloc _verifyUserBloc;
  Timer _timer;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _verifyUserBloc = VerifyUserBloc(userRepo: _userRepository);

    // timer to check for verification every 5 seconds
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        _verifyUserBloc.add(StartCheckingForVericationEvent());
      });
    });
  }

  @override
  void dispose() {
    _verifyUserBloc.close();
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _sendVerificationEmail() {
    _verifyUserBloc.add(ResendVerificationEmailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _verifyUserBloc,
      listener: (
        BuildContext context,
        VerifyUserState state,
      ) {
        if (state is VerifiedState) {
          Navigator.of(context).pushNamed(homeRoute);
        }
      },
      child: BlocBuilder(
          bloc: _verifyUserBloc,
          builder: (
            BuildContext context,
            VerifyUserState state,
          ) {
            return Scaffold(
                body: Container(
                    child: Column(children: [
              Container(
                alignment: Alignment.topLeft,
                padding: spacer.top.xxs,
                margin: spacer.left.none,
                child: Text(
                  'Verify Email',
                  style: primaryH1Bold,
                  textAlign: TextAlign.left,
                ),
              ),
              RaisedButton(
                child: Text("Resend verification email"),
                onPressed: _sendVerificationEmail,
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.grey,
              )
            ])));
          }),
    );
  }
}
