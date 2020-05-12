import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/common/common_errors.dart';
import 'package:dubs_app/common/text_validator.dart';
import 'package:dubs_app/model/user.dart';
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
    // change states to loading
    yield LoginLoadingState();

    // validate inputs
    InvalidInputState validateInputs = _validateUserEvent(event);
    if (validateInputs != null) {
      yield validateInputs;
      return;
    }

    // contact the repo
    User user;
    try {
      user = await _userRepo
          .loginUser(event.email, event.password)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      yield AuthenticationErrorState("Failed to login to backend");
      return;
    }
    if (user.isVerified) {
      yield LoggedInState(user);
    } else {
      yield UnverifiedUserState(user);
    }
  }

  InvalidInputState _validateUserEvent(LoginUserEvent event) {
    String emailError;
    String passwordError;
    if (event.email == null || event.email.length == 0) {
      emailError = EMPTY_EMAIL;
    } else if (!TextValidator.isValidEmail(event.email)) {
      emailError = INVALID_EMAIL_FORMAT;
    }

    if (event.password == null || event.password.length == 0) {
      passwordError = EMPTY_PASSWORD;
    }

    if (emailError != null || passwordError != null) {
      return InvalidInputState(emailError, passwordError);
    }
    return null;
  }

  Stream<LoginState> mapAppStartToState() async* {
    final isLoggedIn = await _userRepo.isLoggedIn();
    if (isLoggedIn) {
      User user = await _userRepo.getUser();
      if (user.isVerified) {
        yield LoggedInState(user);
      } else {
        yield UnverifiedUserState(user);
      }
    } else {
      yield NotLoggedInState();
    }
  }
}
