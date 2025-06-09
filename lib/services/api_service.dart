import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sarpras_management/models/category_model.dart';
import 'package:sarpras_management/models/product_model.dart';

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



}