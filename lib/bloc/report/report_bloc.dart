// report_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:easy_coupon/models/models.dart';
import 'package:easy_coupon/repositories/repositories.dart';

import 'report_event.dart';
import 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepository;

  ReportBloc(this._reportRepository) : super(ReportInitial()) {
    on<GetData>(_onGetData);
  }

  void _onGetData(GetData event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    try {
      List<ReportDataModel> reportData;
      if (event.startDate.isEmpty && event.endDate.isEmpty) {
        reportData = await _reportRepository.get();
      } else {
        reportData = await _reportRepository.getByDateRange(
            event.startDate, event.endDate);
      }
      emit(ReportLoaded(reportData: reportData));
    } catch (e) {
      emit(ReportError(error: e.toString()));
    }
  }
}
