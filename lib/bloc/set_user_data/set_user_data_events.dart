import 'package:dubs_app/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SetUserDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to set the user information
class SetInfoEvent extends SetUserDataEvent {
  MutableUserData userData;

  SetInfoEvent(this.userData);

  @override
  String toString() => 'SetInfoEvent';
}
