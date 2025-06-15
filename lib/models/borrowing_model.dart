// Hapus import intl
// import 'package:intl/intl.dart';
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

class Borrowing {
  final int id;
  final Post? product;
  final User? user;
  final int jumlah;
  final DateTime? waktuPeminjaman;
  final DateTime? batasPengembalian;
  final String status;

  Borrowing({
    required this.id,
    required this.product,
    required this.user,
    required this.jumlah,
    this.waktuPeminjaman,
    this.batasPengembalian,
    required this.status,
  });

  factory Borrowing.fromJson(Map<String, dynamic> json) {
    print('Borrowing JSON: $json');
    print('Product JSON: ${json['product']}');
    print('User JSON: ${json['user']}');
    print('--------------------BATAS SUCI-------------------');

    return Borrowing(
      id: json['id'] as int,
      product: json['product'] != null && json['product'] is Map<String, dynamic>
          ? Post.fromJson(json['product'])
          : null,
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'])
          : null,
      jumlah: json['jumlah'] as int,
      waktuPeminjaman: json['waktu_peminjaman'] != null
          ? DateTime.tryParse(json['waktu_peminjaman'])
          : null,
      batasPengembalian: json['batas_pengembalian'] != null
          ? DateTime.tryParse(json['batas_pengembalian'])
          : null,
      status: json['status'] as String,
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
}

class BorrowingRequest {
  final int productId;
  final int jumlah;

  BorrowingRequest({required this.productId, required this.jumlah});

  Map<String, String> toMap() {
    return {
      'product_id': productId.toString(),
      'jumlah': jumlah.toString(),
    };
  }
}
