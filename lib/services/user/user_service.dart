import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/user/user_model.dart';

class UserService {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  // Stream of users' real-time updates
  Stream<List<UserModel>> getUsersStream() {
    return _userCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<List<UserModel>> getUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _userCollection.doc(user.id).update(user.toJson());
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }

  Future<void> updateCount(int val, String userId) async {
    final docRef = _userCollection.doc(userId);
    // Get the document snapshot
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final data = snapshot.data();
      final currentCount = (data as Map<String, dynamic>)['studentCount'];

      // Check if currentCount is less than 30
      if (currentCount != null && currentCount <= 30 && currentCount + val > 0) {
        // Update the count field
        await docRef.update({'studentCount': FieldValue.increment(-val)});
      } else {
        throw Exception('Reached maximum token');
      }
    } else {
      throw Exception('Document does not exist');
    }
  }
}
