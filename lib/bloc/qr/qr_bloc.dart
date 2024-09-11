import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:easy_coupon/repositories/qrcode/qr_repository.dart';
import 'package:equatable/equatable.dart';

part 'qr_event.dart';
part 'qr_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final QrCodeRepository _qrCodeRepository;
  StreamSubscription<List<QRModel>>? _qrCodeStreamSubscription;

  QrCodeBloc(this._qrCodeRepository) : super(QrCodeInitial()) {
    on<CreateQrCodeEvent>(_onCreateQrCodeEvent);
    on<QrCodeReadEvent>(_onQrCodeReadEvent);
    on<QrCodeLoadEvent>(_onQrCodeLoadEvent);
    on<QrCodeDeleteEvent>(_onQrCodeDeleteEvent);
    on<LoadQrCodesByUid>(_onLoadQrCodesByUid);
    
  }

  Future<void> _onCreateQrCodeEvent(
      CreateQrCodeEvent event, Emitter<QrCodeState> emit) async {
    try {
      await _qrCodeRepository.createQrCode(event.qrCode);
      emit(QrCodeCreated(event.qrCode));
    } catch (e) {
      emit(const QrCodeFailure('Failed to create QR code'));
    }
  }

  Future<void> _onQrCodeReadEvent(
      QrCodeReadEvent event, Emitter<QrCodeState> emit) async {
    try {
      emit(QrCodeLoading());
      final qrCodeStreamResponse = _qrCodeRepository.getQRCodeStream();
      await _qrCodeStreamSubscription?.cancel();
      _qrCodeStreamSubscription = qrCodeStreamResponse.listen((qrcodes) {
        add(QrCodeLoadEvent(qrcodes));
      });
    } catch (e) {
      emit(const QrCodeFailure('Failed to load qrcodes'));
    }
  }

  void _onQrCodeLoadEvent(QrCodeLoadEvent event, Emitter<QrCodeState> emit) {
    try {
      emit(QrCodeLoaded(event.qrcodes));
    } catch (e) {
      emit(const QrCodeFailure('Failed to load qrcodes'));
    }
  }

  Future<void> _onQrCodeDeleteEvent(
      QrCodeDeleteEvent event, Emitter<QrCodeState> emit) async {
    try {
      if (state is QrCodeLoaded) {
        await _qrCodeRepository.deleteQrCode(event.id);
      }
    } catch (e) {
      emit(const QrCodeFailure('Failed to delete qrcodes'));
    }
  }

  FutureOr<void> _onLoadQrCodesByUid(
    LoadQrCodesByUid event, Emitter<QrCodeState> emit) async {
  try {
    emit(QrCodeLoading());

    final qrCodes = await _qrCodeRepository.getQRCodeByUidWithFilter(
      event.uid,
      event.startDate,
      event.endDate,
      event.canteenType,
      reportType: event.reportType, // Include reportType from the event
    );

    emit(QrCodeLoaded(qrCodes));
  } catch (e) {
    emit(const QrCodeFailure('Failed to load QR codes by UID'));
  }
}


  @override
  Future<void> close() {
    _qrCodeStreamSubscription?.cancel();
    return super.close();
  }
}
