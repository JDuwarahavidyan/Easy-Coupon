import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String userName;
  final bool isFirstTime;
  final String createdAt;
  final String role;
  final int studentCount;
  final int canteenCount;
  final String? profilePic;

  const UserModel({
    required this.userName,
    required this.email,
    required this.id,
    this.isFirstTime = true,
    required this.createdAt,
    required this.role,
    required this.studentCount,
    required this.canteenCount,
    this.profilePic,
  });

  // Factory constructor for creating a User instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      isFirstTime: json['isFirstTime'] ?? true,
      createdAt: json['createdAt'],
      role: json['role'] as String,
      studentCount: json['studentCount'] ?? 30,
      canteenCount: json['canteenCount'] ?? 0,
      profilePic: json['profilePic'] ?? '',
    );
  }

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'isFirstTime': isFirstTime,
      'createdAt': createdAt,
      'role': role,
      'studentCount': studentCount,
      'canteenCount': canteenCount,
      'profilePic': profilePic,
    };
  }

  @override
  List<Object?> get props => [
        userName,
        email,
        id,
        isFirstTime,
        createdAt,
        role,
        studentCount,
        canteenCount,
        profilePic,
      ];
}
