import 'package:sarpras_management/models/category_model.dart';

class Post {
  final Category? category;
  final Location? location;
  final Condition? condition;
  final int locationId;
  final int conditionId;
  final int id;
  final int stok;
  final String name;
  final String image;
  final String merek;
  final String tipe;
  final String kodeBarang;
  final DateTime? tahunPengadaan;

  Post({
    required this.category,
    required this.condition,
    required this.location,
    required this.locationId,
    required this.conditionId,
    required this.id,
    required this.stok,
    required this.name,
    required this.image,
    required this.merek,
    required this.tipe,
    required this.kodeBarang,
    required this.tahunPengadaan,
  });

  String get imageUrl => 'http://127.0.0.1:8000/storage/post-images/$image';

  factory Post.fromJson(Map<String, dynamic> json) {
    print('Parsing post: $json');
    return Post(
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      condition: json['condition'] != null ? Condition.fromJson(json['condition']) : null,
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      locationId: json['location_id'] ?? 0,
      conditionId: json['condition_id'] ?? 0,
      id: json['id'] ?? 0,
      stok: json['stok'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      merek: json['merek'] ?? '',
      tipe: json['tipe'] ?? '',
      kodeBarang: json['kode_barang'] ?? '',
      tahunPengadaan: json['tahun_pengadaan'] != null
          ? DateTime.tryParse(json['tahun_pengadaan'])
          : null,
    );
  }
}
