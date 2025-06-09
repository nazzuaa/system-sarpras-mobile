import 'package:sarpras_management/models/category_model.dart';

class Post {
  final Category category;
  final int locationId;
  final int conditionId;
  final int id;
  final int stok;
  final String name;
  final String image;
  final String merek;
  final String tipe;
  final String kodeBarang;
  // final DateTime tahunPengadaan;


  Post({
     required this.category,
     required this.locationId,
     required this.conditionId,
     required this.id,
     required this.stok,
     required this.name,
     required this.image,
     required this.merek,
     required this.tipe,
     required this.kodeBarang,
  });

  String get imageUrl => 'http://127.0.0.1:8000/storage/post-images/$image';

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
       category: Category.fromJson(json['category']),
       locationId: json['location_id'] as int,
       conditionId: json['condition_id'] as int,
       id: json['id'] as int,
       stok: json['stok'] as int,
       name: json['name'] as String,
       image: json['image'] as String,
       merek: json['merek'] as String,
       tipe: json['tipe'] as String,
       kodeBarang: json['kode_barang'] as String,
    );
  }
}