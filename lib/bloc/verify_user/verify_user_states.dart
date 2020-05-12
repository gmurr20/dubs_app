import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VerifyUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class NotVerifiedState extends VerifyUserState {
  @override
  String toString() => 'NotVerifiedState';
}

class VerifiedState extends VerifyUserState {
  @override
  String toString() => 'VerifiedState';
}

class CheckingVerifcationErrorState extends VerifyUserState {
  @override
  String toString() => 'CheckingVerifcationErrorState';
}

class ResendingEmailState extends VerifyUserState {
  @override
  String toString() => 'ResendingEmailState';
}

class ResendingErrorState extends VerifyUserState {
  final String errorMessage;

  ResendingErrorState(this.errorMessage);

  @override
  String toString() => 'ResendingErrorState';
}
