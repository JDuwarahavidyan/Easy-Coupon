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

class UpdateCountEvent extends UserEvent {
  final int val;
  final String userId;

  const UpdateCountEvent(this.val, this.userId);

  @override
  List<Object> get props => [val, userId];
}

class ScannedDataEvent extends UserEvent {
  final Barcode result;
  final int val;
  final String userId;

  const ScannedDataEvent(this.result, this.val, this.userId);

  @override
  List<Object> get props => [result, val, userId];
}

class UserGenerateQREvent extends UserEvent {
  final String canteenUserId;

  const UserGenerateQREvent(this.canteenUserId);

  @override
  List<Object> get props => [canteenUserId];
}


class FetchUserRoleEvent extends UserEvent {
  final String userId;

  const FetchUserRoleEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateCanteenCountEvent extends UserEvent {
  final int val;
  final String canteenUserId;

  const UpdateCanteenCountEvent(this.val, this.canteenUserId);

  @override
  List<Object> get props => [val, canteenUserId];
}

class FetchCanteenUserNameEvent extends UserEvent {
  final String canteenUserId;

  const FetchCanteenUserNameEvent(this.canteenUserId);

  @override
  List<Object> get props => [canteenUserId];

}


