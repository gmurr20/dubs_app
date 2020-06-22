import 'package:dubs_app/screen/verify_user/tutorial/tutorial_events.dart';
import 'package:dubs_app/screen/verify_user/tutorial/tutorial_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class CircleAnimationBloc extends Bloc<CircleAnimationEvent, CircleAnimation> {
  @override
  CircleAnimation get initialState => CircleAnimationState();

  @override
  Stream<CircleAnimationState> mapEventToState(
      CircleAnimationEvent event) async* {}
}
