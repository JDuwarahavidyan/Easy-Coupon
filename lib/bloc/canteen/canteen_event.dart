part of 'canteen_bloc.dart';

abstract class CanteenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAuthorizedUsers extends CanteenEvent {}
