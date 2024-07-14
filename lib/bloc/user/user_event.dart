part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


final class UserUpdateEvent extends UserEvent {
  final UserModel user;

  const UserUpdateEvent(this.user);

  @override
  List<Object> get props => [user];
}

final class UserDeleteEvent extends UserEvent {
  final String id;

  const UserDeleteEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class UserReadEvent extends UserEvent {
  
  @override
  List<Object> get props => [];
}


final class UserLoadEvent extends UserEvent {
  final List<UserModel> users;

  const UserLoadEvent(this.users);

  @override
  List<Object> get props => [users];
}


final class UserReadAllEvent extends UserEvent {
  const UserReadAllEvent();
}



