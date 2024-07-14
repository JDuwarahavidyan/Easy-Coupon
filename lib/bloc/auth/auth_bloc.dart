import 'package:easy_coupon/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthStateInitial()) {
  on<AppStartedEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        final isSignedIn = await authRepository.isSignedIn();
        if (isSignedIn) {
          final user = authRepository.getCurrentUser();
          if (user != null) {
            final isFirstTime = await authRepository.isFirstTimeLogin(user);
            if (isFirstTime) {
              emit(FirstTimeLogin(user));
            } else {
              final isSessionExpired =
                  await authRepository.checkSessionExpiry();
              if (isSessionExpired) {
                add(LoggedOutEvent());
              } else {
                final userModel = await authRepository.getUserDetails(user.uid);
                if (userModel.role == 'student') {
                  emit(StudentAuthenticated(user));
                } else if (userModel.role == 'canteena') {
                  emit(CanteenAAuthenticated(user));
                }  else if (userModel.role == 'canteenb') {
                  emit(CanteenBAuthenticated(user));
                }else {
                  emit(Authenticated(user));
                }
              }
            }
          }
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });

    on<LoggedInEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        final user = await authRepository.signInWithUsernameAndPassword(
            event.username, event.password);
        final isFirstTime = await authRepository.isFirstTimeLogin(user);
        if (isFirstTime) {
          emit(FirstTimeLogin(user));
        } else {
          final userModel = await authRepository.getUserDetails(user.uid);
          if (userModel.role == 'student') {
            emit(StudentAuthenticated(user));
          } else if (userModel.role == 'canteena') {
            emit(CanteenAAuthenticated(user));
          } else if((userModel.role == 'canteenb') ){
            emit(CanteenBAuthenticated(user));
          }
        }
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await authRepository.registerNewUser(
            event.email, event.password, event.username, event.role);
        emit(RegistrationSuccessful());
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });

    on<LoggedOutEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await authRepository.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });

    on<UpdatePasswordEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await authRepository.updatePassword(
            event.currentPassword, event.newPassword);
        emit(PasswordUpdated());
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await authRepository.sendPasswordResetEmail(event.email);
        emit(ResetEmailSent());
      } catch (e) {
        emit(AuthStateError('$e'));
      }
    });
  }
}
