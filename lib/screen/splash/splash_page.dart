import 'dart:async';

import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/bloc/splash/splash_bloc.dart';
import 'package:dubs_app/bloc/splash/splash_events.dart';
import 'package:dubs_app/bloc/splash/splash_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

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

  Logger _logger = getLogger("SplashPage");

  // animation stuff
  Timer _timerLogo;
  bool _startLogoAnimation = false;
  final int ANIMATION_TIME_MSEC = 100;
  Timer _navigateTimer;
  bool _startNavigation = false;
  SplashState _navigationState;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _bloc = SplashBloc(userRepo: _userRepository);
<<<<<<< HEAD
    //  _bloc.add(AppStartEvent());
=======
    _bloc.add(AppStartEvent());
>>>>>>> gregs_shit/master
    _timerLogo = Timer(const Duration(seconds: 2), () {
      setState(() {
        _startLogoAnimation = true;
      });
    });
    _navigateTimer = Timer(const Duration(seconds: 4), () {
      setState(() {
        _startNavigation = true;
        _navigateToNextPage();
      });
    });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _navigateToNextPage() {
    _logger.v(
        "_navigateToNextPage- entered with state ${_startNavigation} and ${_navigationState}");
    if (!_startNavigation || _navigationState == null) {
      return;
    }
    if (_navigationState is SplashLoggedInState) {
      SplashLoggedInState currState = _navigationState;
      switch (currState.user.authState) {
        case UserAuthState.FULLY_LOGGED_IN:
          {
            Navigator.of(context)
                .pushNamed(homeRoute, arguments: currState.user);
            return;
          }
        case UserAuthState.NOT_VERIFIED:
          {
            Navigator.of(context)
                .pushNamed(verifyUserRoute, arguments: currState.user);
            return;
          }
        case UserAuthState.NO_USERNAME:
          {
            Navigator.of(context)
                .pushNamed(addUsernameRoute, arguments: currState.user);
            return;
          }
      }
    } else if (_navigationState is SplashNotLoggedInState) {
      Navigator.of(context).pushNamed(loginRoute);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (
        BuildContext context,
        SplashState state,
      ) {
        _navigationState = state;
        _navigateToNextPage();
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
                      duration: Duration(milliseconds: ANIMATION_TIME_MSEC),
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
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}
