part of 'qr_bloc.dart';

sealed class QrCodeState extends Equatable {
  const QrCodeState();

  @override
  List<Object> get props => [];
}

final class QrCodeInitial extends QrCodeState {}

final class QrCodeLoading extends QrCodeState {}

final class QrCodeLoaded extends QrCodeState {
  final List<QRModel> qrcodes;

  const QrCodeLoaded(this.qrcodes);

  @override
  List<Object> get props => [qrcodes];
}

final class QrCodeFailure extends QrCodeState {
  final String message;

  const QrCodeFailure(this.message);

  @override
  List<Object> get props => [message];
}

class QrCodeRoleLoading extends QrCodeState {}

final class QrCodeCreated extends QrCodeState {
  final QRModel qrCode;

  const QrCodeCreated(this.qrCode);

  @override
  List<Object> get props => [qrCode];
}
