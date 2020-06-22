import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TutorialState extends Equatable {
  @override
  List<Object> get props => [];
}

class CircleAnimationState extends TutorialState {
  @override
  String toString() => 'CircleAnimationState';

  int index;

  bool isHalfWay;

  bool isToggled;

  Color backGroundColor;

  Color foreGroundColor;

  CircleAnimationState(this.index, this.isHalfWay, this.isToggled,
      this.backGroundColor, this.foreGroundColor);
}

// This is some BS where the state always has to change
class TempAnimationState extends TutorialState {
  CircleAnimationState state;

  TempAnimationState(this.state);

  @override
  String toString() => 'TempAnimationState';
}
