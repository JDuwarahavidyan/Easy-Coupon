part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthEvent {}

class LoggedInEvent extends AuthEvent {
  final String username;
  final String password;

  const LoggedInEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LoggedOutEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String role;

  const SignUpEvent({required this.email, required this.password, required this.username, required this.role});

  @override
  List<Object> get props => [email, password, username, role];
}

class UpdatePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordEvent({required this.currentPassword, required this.newPassword});

  @override
  List<Object> get props => [currentPassword, newPassword];
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}