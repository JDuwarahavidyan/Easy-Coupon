import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';

import '../../exception/expceptions.dart';

class QrCodeService {
  final CollectionReference _qrCodeCollection =
      FirebaseFirestore.instance.collection('qrcodes');

  Future<void> createQrCode(QRModel qrcode) async {
    try {
      String id = _qrCodeCollection.doc().id;
      final newQrCode = QRModel(
        id: id,
        studentId: qrcode.studentId,
        canteenId: qrcode.canteenId,
        canteenType: qrcode.canteenType,
        studentName: qrcode.studentName,
        canteenName: qrcode.canteenName,
        scannedAt: qrcode.scannedAt,
        count: qrcode.count,
      );
      await _qrCodeCollection.doc(id).set(newQrCode.toJson());
    } catch (e) {
      throw CustomAuthException('Error creating qrcode: $e');
    }
  }

  Stream<List<QRModel>> getQRCodeStream() {
    return _qrCodeCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<QRModel?> getQRCode(String qrCodeId) async {
    try {
      DocumentSnapshot doc = await _qrCodeCollection.doc(qrCodeId).get();
      if (doc.exists) {
        return QRModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw CustomAuthException('Error getting qrcode: $e');
    }
  }

  Future<void> deleteQrCode(String qrCodeId) async {
    try {
      await _qrCodeCollection.doc(qrCodeId).delete();
    } catch (e) {
      throw CustomAuthException('Error deleting qrcode: $e');
    }
  }

  Stream<List<QRModel>> getQRCodeStreamByUid(String uid) {
    return _qrCodeCollection.where("studentId", isEqualTo: uid).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<List<QRModel>> getQRCodeByUidWithFilter(
      String uid, DateTime? startDate, DateTime? endDate,
      {required String reportType}) async {
    try {
      final QuerySnapshot querySnapshot;

      // Determine the field to query based on the report type
      if (reportType == 'canteen_a_report') {
        querySnapshot =
            await _qrCodeCollection.where("canteenId", isEqualTo: uid).get();
      } else if (reportType == 'student_report') {
        querySnapshot =
            await _qrCodeCollection.where("studentId", isEqualTo: uid).get();
      } else {
        throw CustomAuthException('Invalid report type: $reportType');
      }

      final qrCodes = querySnapshot.docs
          .map((doc) => QRModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return qrCodes.where((qrCode) {
        final scannedAt = qrCode.scannedAt;
        if (startDate != null && endDate != null) {
          return scannedAt.isAfter(startDate) &&
              scannedAt.isBefore(endDate.add(const Duration(days: 1)));
        } else if (startDate != null) {
          return scannedAt.isAfter(startDate);
        } else if (endDate != null) {
          return scannedAt.isBefore(endDate.add(const Duration(days: 1)));
        }
        return true;
      }).toList();
    } catch (e) {
      throw CustomAuthException('Error getting QR codes with filter: $e');
    }
  }
}
