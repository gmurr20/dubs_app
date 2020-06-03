import 'package:dubs_app/bloc/splash/splash_bloc.dart';
import 'package:dubs_app/bloc/splash/splash_events.dart';
import 'package:dubs_app/bloc/splash/splash_states.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _bloc = SplashBloc(userRepo: _userRepository);
    _bloc.add(AppStartEvent());
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
              body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/DubsLogo.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
