import 'dart:async';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_bloc.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_events.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:dubs_app/screen/login/login_page.dart';
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
  final _logger = getLogger("VerifyUserPage");

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
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  void deactivate() {
    _logger.v("deactivate- Entered");
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _sendVerificationEmail() {
    _verifyUserBloc.add(ResendVerificationEmailEvent());
  }

  void _leavePage() {
    _verifyUserBloc.add(LeavePageEvent());
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
          Navigator.of(context).pushNamed(addUsernameRoute);
        }
        if (state is LoggedOutState) {
          Navigator.of(context).pushNamed(loginRoute);
        }
      },
      child: BlocBuilder(
          bloc: _verifyUserBloc,
          builder: (
            BuildContext context,
            VerifyUserState state,
          ) {
            return Scaffold(
                backgroundColor: DarwinRed,
                body: Container(
                    child: Column(children: [
                  // this close button will give the user an escape hatch
                  // incase they lost the original email address and need to create a different account
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      alignment: Alignment.topLeft,
                      padding: spacer.top.lg + spacer.left.md,
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 28,
                      onPressed: _leavePage,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: spacer.top.sm,
                    margin: spacer.left.md + spacer.bottom.xs,
                    child: Text(
                      'Verify your email address',
                      style: primaryH1Bold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: spacer.left.md + spacer.bottom.sm + spacer.right.md,
                    child: Text(
                      'We sent a verification email to <Email Address>. Please check your inbox and verify your account to continue. \n\nIf you do not recieve the verification email in a few minutes, please click the button below to re-send a verification email.',
                      style: primaryPBold,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Resend verification email"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: _sendVerificationEmail,
                    color: Colors.white,
                    textColor: Colors.black,
                    splashColor: Colors.grey,
                  )
                ])));
          }),
    );
  }
}
