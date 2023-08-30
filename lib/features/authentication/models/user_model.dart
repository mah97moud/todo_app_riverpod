import 'dart:convert';

class UserModel {
  const UserModel({required this.id, required this.isVerified});

  final int id;
  final bool isVerified;

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  factory UserModel.fromMap(Map<String, dynamic> myMap) {
    return UserModel(
      id: myMap['id'],
      isVerified: myMap['isVerified'],
    );
  }

  Map<String, dynamic> toMap() => {'id': id, 'isVerified': isVerified};

  String toJson() => jsonEncode(toMap());
}
