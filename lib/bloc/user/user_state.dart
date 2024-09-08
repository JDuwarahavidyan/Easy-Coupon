part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<UserModel> users;

  const UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UserQRGenerated extends UserState {
  final String qrData;

  const UserQRGenerated(this.qrData);

  @override
  List<Object> get props => [qrData];
}


class UserRoleFetched extends UserState {
  final String role;

  const UserRoleFetched(this.role);

  @override
  List<Object> get props => [role];
}
class UserRoleLoading extends UserState {}



class CanteenUserNameLoading extends UserState {}


class CanteenUserNameFetched extends UserState {
  final String canteenUserName;

  const CanteenUserNameFetched (this.canteenUserName);

  @override
  List<Object> get props => [canteenUserName];

}

class UploadPicture extends UserState {
	final String userImage;

	const UploadPicture(this.userImage);

	@override
  List<Object> get props => [userImage];
}

class UploadPictureLoading extends UserState {}
class UploadPictureSuccess extends UserState {
	final String userImage;

	const UploadPictureSuccess(this.userImage);

	@override
  List<Object> get props => [userImage];
}


