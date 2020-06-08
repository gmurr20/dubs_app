import 'package:dubs_app/bloc/new_user/new_user_events.dart';
import 'package:dubs_app/bloc/new_user/new_user_states.dart';
import 'package:dubs_app/common/common_errors.dart';
import 'package:dubs_app/common/text_validator.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class NewUserBloc extends Bloc<NewUserEvent, NewUserState> {
  final UserRepository _userRepo;
  final _logger = getLogger("NewUserBloc");

  NewUserBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  NewUserState get initialState => NotLoggedInNewState();

  @override
  Stream<NewUserState> mapEventToState(NewUserEvent event) async* {
    _logger.v("mapEventToState- Entering");
    if (event is AddUserEvent) {
      yield* mapAddUserEvent(event);
    }
  }

  Stream<NewUserState> mapAddUserEvent(AddUserEvent event) async* {
    _logger.v("mapAddUserEvent- Entering");
    // change states to loading
    yield LoadingState();

    // validate inputs
    InvalidInputState validateInputs = _validateAddUserEvent(event);
    if (validateInputs != null) {
      _logger.d("mapAddUserEvent- Inputs are invalid");
      yield validateInputs;
      return;
    }

    // sanity check that user is not already logged in
    if (await _userRepo.isLoggedIn()) {
      _logger
          .e("mapAddUserEvent- User is logged in. Can't create another user");
      // TODO- maybe sign them out and continue
      yield LoggedInState(await _userRepo.getUser());
      return;
    }

    // contact the repo
    User newUser;
    try {
      newUser = await _userRepo.createUser(event.email, event.password1);
    } catch (e) {
      _logger.e("mapAddUserEvent- Failed to create a user with error '" +
          e.toString() +
          "'");
      yield LoginErrorState(e.toString());
      return;
    }
    _logger.d("mapAddUserEvent- user has been created");

    yield LoggedInState(newUser);
  }

  InvalidInputState _validateAddUserEvent(AddUserEvent event) {
    _logger.v("_validateAddUserEvent- entering");
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
      _logger.v("_validateAddUserEvent- email error '" +
          checkAndPrint(emailError) +
          "', p1 error '" +
          checkAndPrint(password1Error) +
          "', p2 error '" +
          checkAndPrint(password2Error) +
          "'");
      return InvalidInputState(emailError, password1Error, password2Error);
    }
    return null;
  }
}
