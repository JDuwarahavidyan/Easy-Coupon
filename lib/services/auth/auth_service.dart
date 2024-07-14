import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/exception/expceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/models/user/user_model.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthService(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firestore ?? FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> registerNewUser(
      String email, String password, String username, String role) async {
    try {
      // Check if the username is already taken
      final QuerySnapshot query = await _firebaseFirestore
          .collection('users')
          .where('name', isEqualTo: username)
          .get();
      if (query.docs.isNotEmpty) {
        throw CustomAuthException('The Username is already taken.');
      }

      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = userCredential.user;

      if (user != null) {
        final userModel = UserModel(
          id: user.uid,
          userName: username,
          email: email,
          createdAt: DateTime.now().toIso8601String(),
          isFirstTime: true,
          role: role,
          studentCount: 30,
          canteenCount: 0,
          profilePic: 'assets/nouser.png',
        );
        await _firebaseFirestore.collection('users').doc(user.uid).set(
              userModel.toJson(),
            );
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomAuthException(e.message!);
    } on FirebaseException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

   Future<String> getEmailFromUsername(String username) async {
    try {
      final QuerySnapshot query = await _firebaseFirestore
          .collection('users')
          .where('userName', isEqualTo: username)
          .get();
      if (query.docs.isEmpty) {
        throw CustomAuthException('No user found with this username.');
      }
      return (query.docs.first.data() as Map<String, dynamic>)['email'];
    } on FirebaseException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

Future<UserModel> getUserDetails(String userId) async {
    try {
      final DocumentSnapshot doc =
          await _firebaseFirestore.collection('users').doc(userId).get();
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

   Future<void> updatePassword(String newPassword) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await currentUser.updatePassword(newPassword);
        await _firebaseFirestore
            .collection('users')
            .doc(currentUser.uid)
            .update({'isFirstTime': false});
      }
    } on FirebaseAuthException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }


  Future<bool> isFirstTimeLogin(User user) async {
    try {
      final doc =
          await _firebaseFirestore.collection('users').doc(user.uid).get();
      return doc.exists && doc['isFirstTime'] == true;
    } on FirebaseException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

Future<void> validateAndUpdatePassword(
      String currentPassword, String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }

 Future<void> sendPasswordResetEmail(String email) async {
    try {
      // Check if the email exists in Firestore
      final QuerySnapshot query = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (query.docs.isEmpty) {
        throw CustomAuthException('No user found with this email.');
      }

      // Send password reset email
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw CustomAuthException(e.message!);
    }
  }
}
