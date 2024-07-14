import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



Future<void> updateCount(int val,String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

    // Get the document snapshot
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final currentCount = data?['studentCount'];

      // Check if currentCount is less than 30
      if (currentCount != null &&
          currentCount <= 30 &&
          currentCount + val > 0) {
        // Update the count field
        await docRef.update({'studentCount': FieldValue.increment(-val)});
      } else {
        print('Reached maximum token');
      }
    } else {
      print('Document does not exist');
  }
}

void scannedData(Barcode result, int val,String userId) {
  print("data:${result.code}");
  //print(currentUser!.uid.toString());
  updateCount(val,userId);
}
