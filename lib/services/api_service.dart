import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sarpras_management/models/borrowing_model.dart';
import 'dart:convert';

import 'package:sarpras_management/models/category_model.dart';
import 'package:sarpras_management/models/history_model.dart';
import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/models/user_model.dart';

class ApiService {
   static const String _baseUrl = 'http://127.0.0.1:8000/api';
   

   static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/user'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
      },
    );

    return {
      'statusCode': response.statusCode,
      'body': json.decode(response.body),
    };
  }

 static Future<User> getUser(String token) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/user'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return User.fromJson(jsonData['data']);
  } else {
    throw Exception("Failed to fetch user");
  }
}

  static Future<List<Post>> getProducts(String token, {int? categoryId}) async {
  String url = '$_baseUrl/products';

  if (categoryId != null) {
    url += '?category_id=$categoryId';
  }

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
     print('API response data: $data'); 

    final List<dynamic> productJson = data['data']['products']; 
    return productJson.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load products");
  }
}


static Future<Map<String, dynamic>> borrowingRequest({required BorrowingRequest request,  required String token}) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/borrow'),
      headers: {
      'Content-Type': 'application/x-www-form-urlencoded', 
      'Accept': 'application/json',
       'Authorization': 'Bearer $token',
      },
      body: request.toMap(),
    );

    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }

static Future<Map<String, List<Borrowing>>> getBorrowings(String token) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/borrowings'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final decoded = json.decode(response.body);
    print(decoded); // DEBUG

    final dipinjamList = (decoded['dipinjam'] as List)
        .map((json) => Borrowing.fromJson(json))
        .toList();

    final pendingList = (decoded['pending'] as List)
        .map((json) => Borrowing.fromJson(json))
        .toList();

    return {
      'dipinjam': dipinjamList,
      'pending': pendingList,
    };
  } else {
    throw Exception("Failed to fetch borrowings. Status code: ${response.statusCode}");
  }
}
 

static Future<List<Category>> getCategories(String token) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/categories'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['data'];
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch categories");
  }
}


static Future<List<History>> getHistories(String token) async {
  final response = await http.get(
    Uri.parse('$_baseUrl/histories'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    final List<dynamic> data = jsonBody['data'];

    for (var item in data) {
      print("ITEM JSON: $item");
    }

    return data.map((json) => History.fromJson(json)).toList();
  } else {
    throw Exception("Failed to fetch histories");
  }
}

static Future<Map<String, dynamic>> submitReturn({
    required int peminjamanId,
    required int productId,
    required File imageFile,
    required String note,
    required String token, // kalau pakai Auth
  }) async {
    var uri = Uri.parse('$_baseUrl/pengembalian');

    var request = http.MultipartRequest('POST', uri);

    // header (opsional kalau pakai Sanctum / Bearer token)
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    request.fields['peminjaman_id'] = peminjamanId.toString();
    request.fields['product_id'] = productId.toString();
    request.fields['note'] = note;

    // kirim image
    var imageStream = http.MultipartFile.fromBytes(
      'image',
      await imageFile.readAsBytes(),
      filename: basename(imageFile.path),
    );

    request.files.add(imageStream);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }

}