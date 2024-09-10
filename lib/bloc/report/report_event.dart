import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class GetData extends ReportEvent {
  final String startDate;
  final String endDate;

  const GetData({required this.startDate, required this.endDate});

  @override
  List<Object> get props => [startDate, endDate];
}
