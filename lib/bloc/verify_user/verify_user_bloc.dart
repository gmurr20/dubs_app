import 'package:dubs_app/bloc/verify_user/verify_user_events.dart';
import 'package:dubs_app/bloc/verify_user/verify_user_states.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  final UserRepository _userRepo;

  VerifyUserBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  VerifyUserState get initialState => NotVerifiedState();

  @override
  Stream<VerifyUserState> mapEventToState(VerifyUserEvent event) async* {
    if (event is ResendVerificationEmailEvent) {
      yield ResendingEmailState();
      try {
        await _userRepo.sendEmailVerification();
      } catch (e) {
        yield ResendingErrorState(e.toString());
      }
    } else if (event is StartCheckingForVericationEvent) {
      User user;
      try {
        user = await _userRepo.reloadUser();
      } catch (e) {
        yield CheckingVerifcationErrorState();
        return;
      }
      if (user.isVerified) {
        yield VerifiedState();
        return;
      }
      yield NotVerifiedState();
    }
  }
}
