import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:easy_coupon/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/user/user_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  StreamSubscription <List<UserModel>>? _userStreamSubscription;
  
  @override
  Future<void> close() {
    _userStreamSubscription!.cancel();
    return super.close();
  }

  UserBloc() : super(UserInitial()) {
    on<UserReadEvent>((event, emit) {
      try {
        emit(UserLoading());
        final userStreamResponse = UserService().getUsersStream();
         _userStreamSubscription?.cancel();
        _userStreamSubscription = userStreamResponse.listen((users) {
          add(UserLoadEvent(users));
        });
      } catch (e) {
        emit(const UserFailure('Failed to load users'));
      }
    });

    on<UserLoadEvent>((event, emit) {
      try {
        emit(UserLoaded(event.users));
        
      } catch (e) {
        emit(const UserFailure('Failed to load users'));
      }
    });



    on<UserUpdateEvent>((event, emit) {
       try {
        if (state is UserLoaded) {
          UserService().updateUser(event.user);
        }
    
      } catch (e) {
        emit(const UserFailure('Failed to create user'));
      }
    });

    on<UserDeleteEvent>((event, emit) {
       try {
        if (state is UserLoaded) {
          UserService().deleteUser(event.id);
        }
    
      } catch (e) {
        emit(const UserFailure('Failed to create user'));
      }
    });
  }
}
