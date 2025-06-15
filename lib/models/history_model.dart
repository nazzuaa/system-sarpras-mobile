import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/models/user_model.dart';

String formatTanggalManual(DateTime dateTime) {
   final localTime = dateTime.toLocal();
  const bulanIndo = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

   String twoDigits(int n) => n.toString().padLeft(2, '0');
  String jam = '${twoDigits(localTime.hour)}:${twoDigits(localTime.minute)}';

  return '${localTime.day} ${bulanIndo[localTime.month - 1]} ${localTime.year} - $jam';
}

class History{
  final int id;
  final Post? product;
  final User? user;
  final int jumlah;
  final String status;
   final String? note;
  final String? image;
  final DateTime? waktuPeminjaman;
  final DateTime? batasPengembalian;
  final DateTime? waktuPengembalian;

   History({
    required this.id,
    this.product,
    this.user,
    required this.jumlah,
    required this.status,
    this.note,
    this.image,
    this.waktuPeminjaman,
    this.batasPengembalian,
    this.waktuPengembalian,
  });

  String get imageUrl => 'http://127.0.0.1:8000/storage/post-images/$image';

   factory History.fromJson(Map<String, dynamic> json) {
  final productRaw = json['product'];
  final userRaw = json['user'];

  return History(
    id: json['id'],
    product: productRaw != null && productRaw is Map<String, dynamic>
        ? Post.fromJson(productRaw)
        : null,
    user: userRaw != null && userRaw is Map<String, dynamic>
        ? User.fromJson(userRaw)
        : null,
    jumlah: json['jumlah'] ?? 0,
    waktuPeminjaman: json['waktu_peminjaman'] != null
        ? DateTime.tryParse(json['waktu_peminjaman'])
        : null,
    batasPengembalian: json['batas_pengembalian'] != null
        ? DateTime.tryParse(json['batas_pengembalian'])
        : null,
    waktuPengembalian: json['waktu_pengembalian'] != null
        ? DateTime.tryParse(json['waktu_pengembalian'])
        : null,
    note: json['note'],
    image: json['image'],
    status: json['status'] ?? 'unknown',
  );
}



   String get formattedWaktuPeminjaman {
    if (waktuPeminjaman == null) return '-';
    return formatTanggalManual(waktuPeminjaman!);
  }

  String get formattedBatasPengembalian {
    if (batasPengembalian == null) return '-';
    return formatTanggalManual(batasPengembalian!);
  }

  String get formattedwaktuPengembalian {
    if (waktuPengembalian == null) return '-';
    return formatTanggalManual(waktuPengembalian!);
  }
}