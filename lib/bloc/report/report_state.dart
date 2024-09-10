import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}


class ReportError extends ReportState {
  final String error;

  const ReportError({required this.error});

  @override
  List<Object> get props => [error];
}
