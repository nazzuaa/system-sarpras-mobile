import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/services/api_service.dart';
import 'package:sarpras_management/widgets/AppBar.dart';

class ElektronikScreen extends StatefulWidget {
  final String token;
  final int categoryId;
  final String categoryName;

  const ElektronikScreen({
    super.key,
    required this.token,
    required this.categoryId,
    required this.categoryName,
  });


  @override
  State<ElektronikScreen> createState() => _ElektronikScreenState();
}

class _ElektronikScreenState extends State<ElektronikScreen> {
  List<Post> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchElektronikProducts();
  }

  Future<void> fetchElektronikProducts() async {
  setState(() => isLoading = true);
  

  try {
    final fetchedProducts =
        await ApiService.getProducts(widget.token, categoryId: widget.categoryId);

    setState(() {
      products = fetchedProducts;
      isLoading = false;
    });
  } catch (e) {
    print("Error fetching products: $e");
    setState(() => isLoading = false);
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.arrow_back, size: 20, color: Color(0xFF1E2A5E)),
          ),
        ),
      ),

      const SizedBox(width: 12),

      // Search Bar (responsif)
      Expanded(
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF1E2A5E),
            ),
            prefixIcon: Icon(Icons.search, color: Color(0xFF11366c)),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
        ],
      ),
      SizedBox(height: 20),
      Text(
        "Kategori ${widget.categoryName}",
        style: GoogleFonts.poppins(
          color: Color(0xFF1E2A5E),
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      ),
      Expanded(
  child: isLoading
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.network(
      product.imageUrl,
      height: 60,
    ),
    SizedBox(width: 10),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            product.merek,
            style: GoogleFonts.poppins(fontSize: 12),
          ),
        ),
      ],
    ),
    Spacer(), // ini yang dorong kontainer stok ke kanan
    Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Tersedia: ${product.stok}",
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.green,
            fontWeight: FontWeight.w400
            ),
        ),
      ),
    ),
  ],
)

            );
          },
        ),
),


    ],
  ),
)

    );
  }
}


