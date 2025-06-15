import 'package:sarpras_management/models/category_model.dart';

class User{
  final int id;
  final String name;
  final Kelas? kelas;

  User({
    required this.id,
    required this.name,
    required this.kelas,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      kelas: json['kelas'] != null ? Kelas.fromJson(json['kelas']) : null,
    );
  }
}