import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String userName;
  final String fullName;
  final bool isFirstTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final int studentCount;
  final int canteenCount;
  final String? profilePic;
  final int value;

  const UserModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.id,
    this.isFirstTime = true,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.studentCount,
    required this.canteenCount,
    this.profilePic,
    this.value = 0,
  });

  // Factory constructor for creating a User instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String,
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      isFirstTime: json['isFirstTime'] ?? true,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      role: json['role'] as String,
      studentCount: json['studentCount'] ?? 30,
      canteenCount: json['canteenCount'] ?? 0,
      profilePic: json['profilePic'],
      value: json['value'] ?? 0,
    );
  }

  // Method for converting a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'id': id,
      'userName': userName,
      'email': email,
      'isFirstTime': isFirstTime,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'role': role,
      'studentCount': studentCount,
      'canteenCount': canteenCount,
      'profilePic': profilePic,
      'value': value,
    };
  }

  @override
  List<Object?> get props => [
        userName,
        email,
        id,
        isFirstTime,
        createdAt,
        updatedAt,
        role,
        studentCount,
        canteenCount,
        profilePic,
        value,
      ];

  copyWith({required String fullName}) {}
}
