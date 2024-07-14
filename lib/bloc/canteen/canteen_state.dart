part  of 'canteen_bloc.dart';

abstract class CanteenState extends Equatable {
  @override
  List<Object> get props => [];
}

class CanteenInitial extends CanteenState {}

class CanteenLoading extends CanteenState {}

class CanteenLoaded extends CanteenState {
  final List<String> authorizedUsernames;

  CanteenLoaded(this.authorizedUsernames);

  @override
  List<Object> get props => [authorizedUsernames];
}

class CanteenError extends CanteenState {
  final String message;

  CanteenError(this.message);

  @override
  List<Object> get props => [message];
}
