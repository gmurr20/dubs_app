import 'package:dubs_app/screen/verify_user/tutorial/tutorial_states.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CircleAnimationEvent extends ChangeNotifier {
  @override
  List<Object> get props => [];
}

class IsToggledEvent extends CircleAnimationEvent {
  @override
  String toString() => 'IsToggledEvent';
}
