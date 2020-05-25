import 'package:dubs_app/bloc/set_user_data/set_user_data_events.dart';
import 'package:dubs_app/bloc/set_user_data/set_user_data_states.dart';
import 'package:dubs_app/logger/log_printer.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

class SetUserDataBloc extends Bloc<SetUserDataEvent, SetUserDataState> {
  final UserRepository _userRepo;
  final _logger = getLogger("SetUserDataBloc");

  SetUserDataBloc({@required UserRepository userRepo})
      : assert(userRepo != null),
        _userRepo = userRepo;

  @override
  SetUserDataState get initialState => NotSetState();

  @override
  Stream<SetUserDataState> mapEventToState(SetUserDataEvent event) async* {
    _logger.v("mapEventToState- entering");
    if (event is SetInfoEvent) {
      yield AttemptingToContactState();

      if (!await _userRepo.isLoggedIn()) {
        _logger.e("mapEventToState- Not logged in");
        yield NotLoggedInState();
        return;
      }

      _logger.v("mapEventToState- Attempting to set user data");
      try {
        await _userRepo.setUserData(event.userData);
      } catch (e) {
        _logger.w("mapEventToState- Failed to set user data");
        yield ErrorState(e.toString());
        return;
      }
      yield DataSetState();
    }
  }
}
