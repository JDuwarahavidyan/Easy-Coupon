import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/student.dart';

class ReportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> create({required String number, required String time}) async {
    try {
      await _firestore.collection("MealsPerDayByUser").add({
        "Number": number,
        "Time": time,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ReportDataModel>> fetchReportData(
      {required DateTime startDate, required DateTime endDate}) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('MealsPerDayByUser')
        .where('Date', isGreaterThanOrEqualTo: startDate)
        .where('Date', isLessThanOrEqualTo: endDate)
        .get();

    return querySnapshot.docs.map((doc) {
      return ReportDataModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
