import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SplashEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStartEvent extends SplashEvent {
  @override
  String toString() => 'AppStartEvent';
}
