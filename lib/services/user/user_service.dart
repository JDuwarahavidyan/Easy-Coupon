import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/exception/expceptions.dart';
import 'package:easy_coupon/models/user/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class UserService {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<List<UserModel>> getUsersStream() {
    return _userCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>)).toList());
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw CustomException('Error getting user: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _userCollection.doc(user.id).update(user.toJson());
    } catch (e) {
      throw CustomException('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (e) {
      throw CustomException('Error deleting user: $e');
    }
  }

  Future<void> updateCount(int val, String userId) async {
    final docRef = _userCollection.doc(userId);

    try {
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final currentCount = data['studentCount'];

        if (currentCount != null && currentCount <= 30 && currentCount + val > 0) {
          await docRef.update({'studentCount': FieldValue.increment(-val)});
        } else {
          throw CustomException('Reached maximum token limit');
        }
      } else {
        throw CustomException('Document does not exist');
      }
    } catch (e) {
      throw CustomException('Error updating count: $e');
    }
  }

  Future<void> resetStudentCount(String userId) async {
    try {
      await _userCollection.doc(userId).update({'studentCount': 30});
    } catch (e) {
      throw CustomException('Error resetting student count: $e');
    }
  }

  void scannedData(Barcode result, int val, String userId) {
    try {
      updateCount(val, userId);
    } catch (e) {
      throw CustomException('Error processing scanned data: $e');
    }
  }

  Future<String> generateQRData(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      if (userDoc.exists) {
        final userID = (userDoc.data() as Map<String, dynamic>)['id'] ?? 'unknown';
        return userID;
      } else {
        throw CustomException('User not found');
      }
    } catch (e) {
      throw CustomException('Failed to generate QR data: $e');
    }
  }

  Future<String?> getUserRole(String userId) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(userId).get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['role'] as String?;
      }
      return null;
    } catch (e) {
      throw CustomException('Error getting user role: $e');
    }
  }

  Future<void> updateCanteenCount(int val, String canteenUserId) async {
    try {
      final userDoc = _userCollection.doc(canteenUserId);
      await userDoc.update({
        'canteenCount': FieldValue.increment(val),
      });
    } catch (e) {
      throw CustomException('Failed to update canteen count: $e');
    }
  }

  Future<String?> fetchCanteenUserName(String userId) async {
    try {
      DocumentSnapshot doc = await _userCollection.doc(userId).get();
      if (doc.exists) {
        return (doc.data() as Map<String, dynamic>)['userName'] as String;
      }
      return null;
    } catch (e) {
      throw CustomException('Error getting user name: $e');
    }
  }

  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStoreRef = FirebaseStorage.instance.ref().child('$userId/PP/${userId}_lead');
      await firebaseStoreRef.putFile(
        imageFile,
      );
      String url = await firebaseStoreRef.getDownloadURL();
      await _userCollection.doc(userId).update({'profilePic': url});
      return url;
    } catch (e) {
      throw CustomException('Error getting image: $e');
    }
  }

    Future<void> deleteProfilePicture(String imageUrl ) async {
    final ref = _storage.refFromURL(imageUrl);
    await ref.delete();
  }
}
