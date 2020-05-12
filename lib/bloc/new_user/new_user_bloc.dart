import 'package:dubs_app/bloc/new_user/new_user_events.dart';
import 'package:dubs_app/bloc/new_user/new_user_states.dart';
import 'package:dubs_app/common/common_errors.dart';
import 'package:dubs_app/common/text_validator.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class NewUserBloc extends Bloc<NewUserEvent, NewUserState> {
  final UserRepository _userRepo;

  NewUserBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  NewUserState get initialState => NotLoggedInNewState();

  @override
  Stream<NewUserState> mapEventToState(NewUserEvent event) async* {
    if (event is AddUserEvent) {
      yield* mapAddUserEvent(event);
    }
  }

  Stream<NewUserState> mapAddUserEvent(AddUserEvent event) async* {
    // change states to loading
    yield LoadingState();

    // validate inputs
    InvalidInputState validateInputs = _validateAddUserEvent(event);
    if (validateInputs != null) {
      yield validateInputs;
      return;
    }

    // contact the repo
    User newUser;
    try {
      newUser = await _userRepo
          .createUser(event.email, event.password1)
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      yield LoginErrorState(e.toString());
      return;
    }
    yield LoggedInState(newUser);

    // TODO: update the user information
  }

  InvalidInputState _validateAddUserEvent(AddUserEvent event) {
    String emailError;
    String password1Error;
    String password2Error;
    if (event.email == null || event.email.length == 0) {
      emailError = EMPTY_EMAIL;
    } else if (!TextValidator.isValidEmail(event.email)) {
      emailError = INVALID_EMAIL_FORMAT;
    }

    if (event.password1 == null || event.password1.length == 0) {
      password1Error = EMPTY_PASSWORD;
    }
    if (event.password2 == null || event.password2.length == 0) {
      password2Error = "Confirm password";
    }
    if (event.password1 != event.password2) {
      password2Error = "Passwords do not match";
    }

    if (emailError != null ||
        password1Error != null ||
        password2Error != null) {
      return InvalidInputState(emailError, password1Error, password2Error);
    }
    return null;
  }
}
