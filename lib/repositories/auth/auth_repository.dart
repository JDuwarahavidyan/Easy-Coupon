import 'package:easy_coupon/models/user/user_model.dart';
import 'package:easy_coupon/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository({FirebaseAuthService? firebaseAuthService})
      : _firebaseAuthService = firebaseAuthService ?? FirebaseAuthService();

  Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final int? expiryTime = prefs.getInt('expiryTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (userId != null && expiryTime != null && currentTime < expiryTime) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getUserEmail() async {
    final currentUser = _firebaseAuthService.getCurrentUser();
    return currentUser!.email!;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    final user = _firebaseAuthService.getCurrentUser();
    await _saveSession(user!);
    return user;
  }

  Future<User> registerNewUser(
      String email, String password, String username, String role) async {
    await _firebaseAuthService.registerNewUser(email, password, username, role);
    final user = _firebaseAuthService.getCurrentUser();
    await _saveSession(user!);
    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
    await _clearSession();
  }

  Future<UserModel> getUserDetails(String userId) async {
    return await _firebaseAuthService.getUserDetails(userId);
  }

  User? getCurrentUser() {
    return _firebaseAuthService.getCurrentUser();
  }

  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    await _firebaseAuthService.validateAndUpdatePassword(
        currentPassword, newPassword);
  }

  Future<bool> isFirstTimeLogin(User user) async {
    return await _firebaseAuthService.isFirstTimeLogin(user);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuthService.sendPasswordResetEmail(email);
  }

  Future<User> signInWithUsernameAndPassword(
      String username, String password) async {
    //final email = await _firebaseAuthService.getEmailFromUsername(username);

    await _firebaseAuthService.signInWithEmailAndPassword(username, password);
    print('login');
    final user = _firebaseAuthService.getCurrentUser();
    await _saveSession(user!);
    return user;
  }

  Future<void> _saveSession(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime =
        DateTime.now().add(const Duration(days: 7)).millisecondsSinceEpoch;
    await prefs.setString('userId', user.uid);
    await prefs.setInt('expiryTime', expiryTime);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('expiryTime');
  }

  Future<bool> checkSessionExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final int? expiryTime = prefs.getInt('expiryTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return expiryTime != null && currentTime > expiryTime;
  }
}
