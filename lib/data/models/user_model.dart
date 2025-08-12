import 'package:chargerrr/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    String? name,
    String? avatarUrl,
    required DateTime createdAt,
  }) : super(
          id: id,
          email: email,
          name: name,
          avatarUrl: avatarUrl,
          createdAt: createdAt,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }
}