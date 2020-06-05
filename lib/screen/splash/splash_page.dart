import 'dart:async';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/bloc/splash/splash_bloc.dart';
import 'package:dubs_app/bloc/splash/splash_events.dart';
import 'package:dubs_app/bloc/splash/splash_states.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  final UserRepository userRepository;

  SplashPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc _bloc;

  // animation stuff
  Timer _timerLogo;
  Timer _timerLoading;
  bool _startLogoAnimation = false;
  bool _showLoading = false;
  final int ANIMATION_TIME = 100;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _bloc = SplashBloc(userRepo: _userRepository);
    // _bloc.add(AppStartEvent());
    _timerLogo = Timer(const Duration(seconds: 2), () {
      setState(() {
        _startLogoAnimation = true;
      });
    });
    _timerLoading = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        SplashState state,
      ) {
        if (state is SplashLoggedInState) {
          switch (state.user.authState) {
            case UserAuthState.FULLY_LOGGED_IN:
              {
                Navigator.of(context)
                    .pushNamed(homeRoute, arguments: state.user);
                return;
              }
            case UserAuthState.NOT_VERIFIED:
              {
                Navigator.of(context)
                    .pushNamed(verifyUserRoute, arguments: state.user);
                return;
              }
            case UserAuthState.NO_USERNAME:
              {
                Navigator.of(context)
                    .pushNamed(addUsernameRoute, arguments: state.user);
                return;
              }
          }
        } else if (state is SplashNotLoggedInState) {
          Navigator.of(context).pushNamed(loginRoute);
          return;
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (
          BuildContext context,
          SplashState state,
        ) {
          return Scaffold(
            backgroundColor: DarwinRed,
            body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 56,
                      child: Center(
                        child: Text(
                          'w',
                          style: GoogleFonts.sedgwickAveDisplay(
                            fontSize: 86,
                            color: DarwinRed,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: _startLogoAnimation ? 1 : 0,
                      duration: Duration(milliseconds: ANIMATION_TIME),
                      child: Container(
                        margin: spacer.top.sm,
                        child: Text(
                          'Let’s get dubs.',
                          style: GoogleFonts.sedgwickAve(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _showLoading ? 1 : 0,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
