import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeClickPlusButtonEvent>(homeClickPlusButtonEvent);
    on<HomeClickMinusButtonEvent>(homeClickMinusButtonEvent);
    on<HomeScannerButtonNavigatorEvent>(homeScannerButtonNavigatorEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    //emit(HomeLoadingState());
    //await Future.delayed(Duration(seconds: 3));
    //emit(HomeLoadedSuccessState(student: FirebaseDatabase.instance.ref()))
  }

  FutureOr<void> homeClickPlusButtonEvent(
      HomeClickPlusButtonEvent event, Emitter<HomeState> emit) {
  }

  FutureOr<void> homeClickMinusButtonEvent(
      HomeClickMinusButtonEvent event, Emitter<HomeState> emit) {

  }

  FutureOr<void> homeScannerButtonNavigatorEvent(
      HomeScannerButtonNavigatorEvent event, Emitter<HomeState> emit) {
 

    //emit(HomeNavigateToScannerActionState());
  }
}
