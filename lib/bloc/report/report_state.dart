import 'package:equatable/equatable.dart';
import 'package:easy_coupon/models/student.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportDataModel> reportData;

  const ReportLoaded({required this.reportData});

  @override
  List<Object> get props => [reportData];
}

class ReportError extends ReportState {
  final String error;

  const ReportError({required this.error});

  @override
  List<Object> get props => [error];
}
