import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VerifyUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Force background task to listen for verification
class StartCheckingForVericationEvent extends VerifyUserEvent {
  @override
  String toString() => 'StartCheckingForVericationEvent';
}

// Resend the email to verify the user's email address
class ResendVerificationEmailEvent extends VerifyUserEvent {
  @override
  String toString() => 'ResendVerificationEmail';
}
