import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:easy_coupon/services/qrcode/qr_service.dart';

class QrCodeRepository {
  final QrCodeService _qrCodeService;

  QrCodeRepository(this._qrCodeService);

  Future<void> createQrCode(QRModel qrcode) async {
    await _qrCodeService.createQrCode(qrcode);
  }

  Stream<List<QRModel>> getQRCodeStream() {
    return _qrCodeService.getQRCodeStream();
  }

  Future<QRModel?> getQRCode(String qrCodeId) async {
    return await _qrCodeService.getQRCode(qrCodeId);
  }

  Future<void> deleteQrCode(String qrCodeId) async {
    await _qrCodeService.deleteQrCode(qrCodeId);
  }

  Stream<List<QRModel>> getQRCodeByUidStream(String uid) {
    return _qrCodeService.getQRCodeStreamByUid(uid);
  }

  Future<List<QRModel>> getQRCodeByUidWithFilter(
      String uid, DateTime? startDate, DateTime? endDate,
      {required String reportType}) async {
    return await _qrCodeService.getQRCodeByUidWithFilter(
        uid, startDate, endDate,
        reportType: reportType);
  }
}
