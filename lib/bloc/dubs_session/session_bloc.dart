import 'package:dubs_app/logger/log_printer.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dubs_app/bloc/dubs_session/session_events.dart';
import 'package:dubs_app/bloc/dubs_session/session_states.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  CountState countState = CountState(0);
  final _logger = getLogger("SessionBloc");
  @override
  SessionState get initialState => CountState(0);

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    _logger.v('Print ${countState.count}');
    yield TempAnimationState(countState);
    if (event is IncrementWinEvent) {
      yield CountState(countState.count + 1);
      countState.count += 1;
    } else if (event is DecrementWinEvent) {
      yield CountState(countState.count - 1);
      countState.count -= 1;
    } else if (event is IncrementLossEvent) {
      yield CountState(countState.count + 1);
    } else if (event is DecrementLossEvent) {
      yield CountState(countState.count - 1);
    }
  }
}
