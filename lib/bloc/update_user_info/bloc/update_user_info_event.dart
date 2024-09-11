part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class UploadPictureEvent extends UpdateUserInfoEvent {
	final String file;
	final String userId;

	const UploadPictureEvent(this.file, this.userId);

	@override
  List<Object> get props => [file, userId];
}

class DeleteProfilePictureEvent extends UpdateUserInfoEvent {
  final String imageUrl;

  const DeleteProfilePictureEvent(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}