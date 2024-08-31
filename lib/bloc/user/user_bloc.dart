import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:easy_coupon/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../models/user/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription<List<UserModel>>? _userStreamSubscription;

  UserBloc(this._userRepository) : super(UserInitial()) {
    on<UserReadEvent>(_onUserReadEvent);
    on<UserLoadEvent>(_onUserLoadEvent);
    on<UserUpdateEvent>(_onUserUpdateEvent);
    on<UserDeleteEvent>(_onUserDeleteEvent);
    on<UpdateCountEvent>(_onUpdateCountEvent);
    on<ScannedDataEvent>(_onScannedDataEvent);
    on<UserGenerateQREvent>(_onUserGenerateQREvent);
    on<FetchUserRoleEvent>(_onFetchUserRoleEvent);
    on<UpdateCanteenCountEvent>(_onUpdateCanteenCountEvent);
    on<FetchCanteenUserNameEvent>(_onFetchCanteenUserNameEvent);
  }

  Future<void> _onUserReadEvent(
      UserReadEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final userStreamResponse = _userRepository.getUsersStream();
      await _userStreamSubscription?.cancel();
      _userStreamSubscription = userStreamResponse.listen((users) {
        add(UserLoadEvent(users));
      });
    } catch (e) {
      emit(const UserFailure('Failed to load users'));
    }
  }

  void _onUserLoadEvent(UserLoadEvent event, Emitter<UserState> emit) {
    try {
      emit(UserLoaded(event.users));
    } catch (e) {
      emit(const UserFailure('Failed to load users'));
    }
  }

  Future<void> _onUserUpdateEvent(
      UserUpdateEvent event, Emitter<UserState> emit) async {
    try {
      if (state is UserLoaded) {
        await _userRepository.updateUser(event.user);
        final updatedUsers = (state as UserLoaded).users.map((user) {
          return user.id == event.user.id ? event.user : user;
        }).toList();
        emit(UserLoaded(updatedUsers));
      }
    } catch (e) {
      emit(const UserFailure('Failed to update user'));
    }
  }

  Future<void> _onUserDeleteEvent(
      UserDeleteEvent event, Emitter<UserState> emit) async {
    try {
      if (state is UserLoaded) {
        await _userRepository.deleteUser(event.id);
      }
    } catch (e) {
      emit(const UserFailure('Failed to delete user'));
    }
  }

  Future<void> _onUpdateCountEvent(
      UpdateCountEvent event, Emitter<UserState> emit) async {
    try {
      await _userRepository.updateCount(event.val, event.userId);
    } catch (e) {
      emit(const UserFailure('Failed to update count'));
    }
  }

  void _onScannedDataEvent(ScannedDataEvent event, Emitter<UserState> emit) {
    try {
      _userRepository.updateCount(event.val, event.userId);
    } catch (e) {
      emit(const UserFailure('Failed to handle scanned data'));
    }
  }

  Future<void> _onUserGenerateQREvent(
      UserGenerateQREvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final qrData = await _userRepository.generateQRData(event.canteenUserId);
      emit(UserQRGenerated(qrData));
    } catch (e) {
      emit(const UserFailure('Failed to generate QR code'));
    }
  }

  Future<void> _onFetchUserRoleEvent(
      FetchUserRoleEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final role = await _userRepository.getUserRole(event.userId);
      if (role != null) {
        emit(UserRoleFetched(role));
      } else {
        emit(const UserFailure('User role not found'));
      }
    } catch (e) {
      emit(UserFailure('Failed to fetch user role: $e'));
    }
  }

  Future<void> _onUpdateCanteenCountEvent(
      UpdateCanteenCountEvent event, Emitter<UserState> emit) async {
    try {
      await _userRepository.updateCanteenCount(event.val, event.canteenUserId);
    } catch (e) {
      emit(UserFailure('Failed to update canteen count: $e'));
    }
  }

  Future<void> _onFetchCanteenUserNameEvent(
      FetchCanteenUserNameEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final userName =
          await _userRepository.fetchCanteenUserName(event.canteenUserId);
      if (userName != null) {
        emit(CanteenUserNameFetched(userName));
      } else {
        emit(const UserFailure('User role not found'));
      }
    } catch (e) {
      emit(UserFailure('Failed to fetch user role: $e'));
    }
  }

  @override
  Future<void> close() {
    _userStreamSubscription?.cancel();
    return super.close();
  }
}
