import 'package:easy_coupon/models/user/user_model.dart';
import 'package:easy_coupon/services/user/user_service.dart';

class UserRepository {
  final UserService _userService;

  UserRepository(this._userService);

  Stream<List<UserModel>> getUsersStream() {
    return _userService.getUsersStream();
  }

  Future<UserModel?> getUser(String userId) async {
    return _userService.getUser(userId);
  }

  Future<void> updateUser(UserModel user) async {
    return _userService.updateUser(user);
  }

  Future<void> deleteUser(String userId) async {
    return _userService.deleteUser(userId);
  }

  Future<void> updateCount(int val, String userId) async {
    return _userService.updateCount(val, userId);
  }

  Future<String> generateQRData(String userId) async {
    return _userService.generateQRData(userId);
  }

  Future<String?> getUserRole(String userId) async {
    return _userService.getUserRole(userId);
  }

  Future<void> updateCanteenCount(int val, String canteenUserId) async {
    return _userService.updateCanteenCount(val, canteenUserId);
  }

  Future<String?> fetchCanteenUserName(String userId) async {
    return _userService.fetchCanteenUserName(userId);
  }

  Future<String?> uploadPicture(String file, String userId) async {
    print('user image :${file}');
    return _userService.uploadPicture(file, userId);
  }

  Future<void> deleteProfilePicture(String imageUrl) async {
    return _userService.deleteProfilePicture(imageUrl);
  }
}
