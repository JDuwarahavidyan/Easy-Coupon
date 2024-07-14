part of 'home_bloc.dart';


abstract class HomeState {}

abstract class HomeActionClass extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}



class HomeErrorState extends HomeState {}

class HomeNavigateToReportActionState extends HomeActionClass {}

class HomeNavigateToScannerActionState extends HomeActionClass {}
