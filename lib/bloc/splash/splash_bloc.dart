import 'package:dubs_app/bloc/splash/splash_events.dart';
import 'package:dubs_app/bloc/splash/splash_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository _userRepo;
  final _logger = getLogger("SplashBloc");

  SplashBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  SplashState get initialState => SplashStartState();

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    _logger.v("mapEventToState- Entering");
    if (event is AppStartEvent) {
      yield* _mapAppStartToState(event);
    }
  }

  Stream<SplashState> _mapAppStartToState(AppStartEvent event) async* {
    _logger.v("mapAppStartToState- Entering");
    final isLoggedIn = await _userRepo.isLoggedIn();
    if (isLoggedIn) {
      _logger.d("mapAppStartToState- User is already logged in");
      User user;
      try {
        user = await _userRepo.getUser();
      } catch (e) {
        _logger.e("mapAppStartToState- Failed to get user with error '" +
            e.toString() +
            "'");
        yield SplashNotLoggedInState();
        return;
      }
      yield SplashLoggedInState(user);
    } else {
      _logger.d("mapAppStartToState- not logged in");
      yield SplashNotLoggedInState();
    }
  }
}
