import 'package:sarpras_management/models/borrowing_model.dart';
import 'package:sarpras_management/models/product_model.dart';

class ReturnModel {
  final int id;
  final Post? product;
  final Borrowing peminjaman;
  final String image;
  final String note;

  ReturnModel({
    required this.id,
    required this.product,
    required this.peminjaman,
    required this.image,
    required this.note,
  });

  factory ReturnModel.fromJson(Map<String, dynamic> json) {
    return ReturnModel(
      id: json['id'] as int,
      product: json['product'] != null ? Post.fromJson(json['product']) : null,
      peminjaman: Borrowing.fromJson(json['peminjaman']),
      image: json['image'] ?? '',
      note: json['note'] ?? '',
    );
  }
}
