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
  });

  // Factory constructor for creating a User instance from JSON data
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] as String? ?? '',
      id: json['id'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      isFirstTime: json['isFirstTime'] ?? true,
      createdAt: _parseDate(json['createdAt']),
      updatedAt: _parseDate(json['updatedAt']),
      role: json['role'] as String,
      studentCount: json['studentCount'] ?? 30,
      canteenCount: json['canteenCount'] ?? 0,
      profilePic: json['profilePic'],
    );
  }

// Helper method to parse date
  static DateTime _parseDate(dynamic date) {
    if (date == null) {
      // Handle null dates by assigning a default value or throwing an error
      return DateTime.now(); // Or use another default date
    }

    if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (e) {
        throw ArgumentError('Invalid date format: $date');
      }
    } else {
      throw ArgumentError('Invalid date format: $date');
    }
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
      ];

  copyWith({required String fullName}) {}
}
