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
  LoginState get initialState => NotLoggedInState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AddUserEvent) {
      yield* mapAddUserState(event);
    }
  }

  Stream<LoginState> mapAddUserState(AddUserEvent event) async* {
    yield LoggedInState(
        await _userRepo.createUser(event.email, event.password));
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
