import 'package:dubs_app/bloc/profile/profile_events.dart';
import 'package:dubs_app/bloc/profile/profile_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepo;
  User _currentUser;

  final _logger = getLogger("ProfileBloc");

  ProfileBloc({@required UserRepository userRepo, @required User user})
      : assert(userRepo != null),
        assert(user != null),
        _userRepo = userRepo,
        _currentUser = user;

  @override
  ProfileState get initialState => NormalState(_currentUser);

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    _logger.v("mapEventToState- entering");
    if (event is ProfileLogoutEvent) {
      yield* _handleLogOutEvent(event);
      return;
    }
  }

  Stream<ProfileState> _handleLogOutEvent(ProfileLogoutEvent event) async* {
    _logger.v("_handleLogOutEvent- entering");
    try {
      await _userRepo.logout();
    } catch (e) {
      _logger.e("_handleLogOutEvent- error while logging out: ${e.toString()}");
    }
    yield ProfileLoggedOutState();
  }
}
