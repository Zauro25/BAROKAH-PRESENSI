import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { pengurus, peserta }

UserRole userRoleFromString(String value) {
  return UserRole.values.firstWhere(
    (role) => role.name == value,
    orElse: () => UserRole.peserta,
  );
}

class UserProfile {
  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.createdAt,
  });

  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final DateTime? createdAt;

  String get displayRole => role == UserRole.pengurus ? 'Pengurus' : 'Peserta';

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': phone,
      'createdAt': createdAt ?? DateTime.now(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'] as String,
      name: data['name'] as String? ?? 'Tidak ada nama',
      email: data['email'] as String? ?? '',
      role: userRoleFromString(data['role'] as String? ?? 'peserta'),
      phone: data['phone'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
