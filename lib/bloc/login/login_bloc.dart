import 'package:dubs_app/bloc/login/login_events.dart';
import 'package:dubs_app/bloc/login/login_states.dart';
import 'package:dubs_app/common/common_errors.dart';
import 'package:dubs_app/common/text_validator.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepo;
  final _logger = getLogger("LoginBloc");

  LoginBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  LoginState get initialState => AppStartState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    _logger.v("mapEventToState- Entering");
    if (event is LoginUserEvent) {
      yield* mapLoginUserState(event);
    }
  }

  Stream<LoginState> mapLoginUserState(LoginUserEvent event) async* {
    _logger.v("mapLoginUserState- Entering");
    // change states to loading
    yield LoginLoadingState();

    // validate inputs
    InvalidInputState validateInputs = _validateUserEvent(event);
    if (validateInputs != null) {
      _logger.d("mapLoginUserState- Inputs are invalid");
      yield validateInputs;
      return;
    }

    // contact the repo
    User user;
    try {
      user = await _userRepo.loginUser(event.email, event.password);
    } catch (e) {
      _logger.w("mapLoginUserState- Failed to login to backend. Error: '" +
          e.toString() +
          "'");
      yield AuthenticationErrorState("Failed to login to backend");
      return;
    }
    yield LoggedInState(user);
  }

  InvalidInputState _validateUserEvent(LoginUserEvent event) {
    _logger.v("_validateUserEvent- entering with email '" +
        checkAndPrint(event.email) +
        "'");
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
      _logger.v("_validateUserEvent- email error '" +
          checkAndPrint(emailError) +
          "' and password error '" +
          checkAndPrint(passwordError) +
          "'");
      return InvalidInputState(emailError, passwordError);
    }
    return null;
  }
}
