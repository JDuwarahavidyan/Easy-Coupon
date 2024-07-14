import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/models/user/user_model.dart';

class UserService {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');


//stream of users realtime updates
  Stream<List<UserModel>> getUsersStream() {
    return _userCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      throw e;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _userCollection.doc(user.id).update(user.toJson());
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  } 

  Future<void> deleteUser(String userId) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw e;
    }
  }
}