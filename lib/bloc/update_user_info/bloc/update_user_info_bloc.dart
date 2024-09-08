import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:easy_coupon/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';


part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final UserRepository _userRepository;

  UpdateUserInfoBloc(this._userRepository) : super(UpdateUserInfoInitial()) {
    on<UploadPictureEvent>(_onUploadPictureEvent);
  }

  Future<void> _onUploadPictureEvent(UploadPictureEvent event, Emitter<UpdateUserInfoState> emit) async {
    try {
      emit(UploadPictureLoading());
      final String? userImage = await _userRepository.uploadPicture(event.file, event.userId);
      emit(UploadPictureSuccess(userImage!));
    } catch (e) {
      emit(UploadPictureFailure());
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
