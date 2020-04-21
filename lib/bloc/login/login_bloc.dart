import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepo;

  LoginBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  LoginState get initialState => AppStartState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AppStartEvent) {
      yield* mapAppStartToState();
    } else if (event is LoginUserEvent) {
      yield* mapLoginUserState(event);
    }
  }

  Stream<LoginState> mapLoginUserState(LoginUserEvent event) async* {
    yield LoginLoadingState();
    try {
      yield LoggedInState(
          await _userRepo.loginUser(event.email, event.password));
    } catch (e) {
      yield LoginErrorState(e.toString());
    }
  }

  Stream<LoginState> mapAppStartToState() async* {
    final isLoggedIn = await _userRepo.isLoggedIn();
    if (isLoggedIn) {
      yield LoggedInState(await _userRepo.getUser());
    } else {
      yield NotLoggedInState();
    }
  }
}
