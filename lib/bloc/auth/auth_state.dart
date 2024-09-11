part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

final class AuthStateLoaded extends AuthState {
  final User user;

  const AuthStateLoaded(this.user);

  @override
  List<Object> get props => [user];
}

final class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

final class Unauthenticated extends AuthState {}

final class AuthStateError extends AuthState {
  final String error;
  
  const AuthStateError(this.error);

  @override
  List<Object> get props => [error];
}

class FirstTimeLogin extends AuthState {
  final User user;


  const FirstTimeLogin(this.user);

  @override
  List<Object> get props => [user];
}

class PasswordUpdated extends AuthState {}


class RegistrationSuccessful extends AuthState {}

class ResetEmailSent extends AuthState {}

final class StudentAuthenticated extends AuthState {
  final User user;

  const StudentAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

final class CanteenAAuthenticated extends AuthState {
  final User user;

  const CanteenAAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class CanteenBAuthenticated extends AuthState {
  final User user;

  const CanteenBAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}