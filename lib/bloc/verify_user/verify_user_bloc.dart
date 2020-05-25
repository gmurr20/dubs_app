import 'package:dubs_app/bloc/verify_user/verify_user_events.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  final UserRepository _userRepo;
  final _logger = getLogger("VerifyUserBloc");

  VerifyUserBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  VerifyUserState get initialState => NotVerifiedState();

  @override
  Stream<VerifyUserState> mapEventToState(VerifyUserEvent event) async* {
    _logger.v("mapEventToState - entering");
    if (event is ResendVerificationEmailEvent) {
      _logger.d("mapEventToState - Resending email");
      yield ResendingEmailState();
      try {
        await _userRepo.sendEmailVerification();
      } catch (e) {
        _logger.e(
            "mapEventToState - Failed to send verification email. Error '" +
                e.toString() +
                "'");
        // send state to go back to sign in
        yield ResendingErrorState(e.toString());
      }
      yield NotVerifiedState();
    } else if (event is StartCheckingForVericationEvent) {
      _logger.d("mapEventToState - checking for verification");
      User user;
      try {
        user = await _userRepo.reloadUser();
      } catch (e) {
        _logger.e("mapEventToState - Failed to reload the user '" +
            e.toString() +
            "'");
        yield CheckingVerifcationErrorState();
        return;
      }
      switch (user.authState) {
        case UserAuthState.NOT_VERIFIED:
          {
            yield NotVerifiedState();
            return;
          }
        case UserAuthState.FULLY_LOGGED_IN:
        case UserAuthState.NO_USERNAME:
          {
            yield VerifiedState();
          }
      }
    }
  }
}
