import 'package:dubs_app/logger/log_printer.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:dubs_app/bloc/dubs_session/session_events.dart';
import 'package:dubs_app/bloc/dubs_session/session_states.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  CountState countState = CountState(0, 0);

  final _logger = getLogger("SessionBloc");
  @override
  SessionState get initialState => CountState(0, 0);

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    yield TempAnimationState(countState);
    if (event is IncrementWinEvent) {
      yield CountState(countState.wcount + 1, countState.lcount);
      countState.wcount += 1;
    } else if (event is DecrementWinEvent) {
      yield CountState(countState.wcount - 1, countState.lcount);
      countState.wcount -= 1;
    } else if (event is IncrementLossEvent) {
      yield CountState(countState.lcount + 1, countState.wcount);
      countState.lcount += 1;
    } else if (event is DecrementLossEvent) {
      yield CountState(countState.lcount - 1, countState.wcount);
      countState.lcount -= 1;
    }

    _logger.v(
        'Print Bloc Wins: ${countState.wcount} Losses: ${countState.lcount}');
  }
}
