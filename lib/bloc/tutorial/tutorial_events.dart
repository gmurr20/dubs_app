import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TutorialEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IsToggledEvent extends TutorialEvent {
  @override
  String toString() => 'IsToggledEvent';
}

// the animation is halfway
class HalfwayEvent extends TutorialEvent {
  bool isHalfway;

  HalfwayEvent(this.isHalfway);

  @override
  String toString() => 'HalfwayEvent';
}

// the animation has finished, swap colors
class SwapColorsEvent extends TutorialEvent {
  @override
  String toString() => 'SwapColorsEvent';
}

// go to the next page
class NextPageEvent extends TutorialEvent {
  @override
  String toString() => 'NextPageEvent';
}
