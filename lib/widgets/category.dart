import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/borrowing_model.dart';
import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/services/api_service.dart';

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
      products = fetchedProducts.where((p) => 
  p.category?.name.toLowerCase().trim() == widget.categoryName.toLowerCase().trim()
).toList();

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
              fontSize: 18),
        ),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (context) {
    int jumlah = 0;

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 16),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),

              // Informasi Produk
              buildDetailRow("Nama", product.name),
              buildDetailRow("Merek", product.merek),
              buildDetailRow("Tipe", product.tipe ?? "-"),

              // Jumlah
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Jumlah", style: GoogleFonts.poppins(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, color: Color(0xFF1E2A5E)),
                          onPressed: () {
                            if (jumlah > 0) {
                              setState(() {
                                jumlah--;
                              });
                            }
                          },
                        ),
                        Text(
                          '$jumlah',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Color(0xFF1E2A5E)),
                          onPressed: () {
                            if (jumlah < product.stok) {
                              setState(() {
                                jumlah++;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tombol Pinjam
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: jumlah == 0 ? null : () {
  Future.microtask(() {
    Navigator.pop(context);
  });

  final request = BorrowingRequest(
    productId: product.id,
    jumlah: jumlah,
  );

  ApiService.borrowingRequest(
    request: request,
    token: widget.token,
  ).then((res) {
    // Beri notifikasi atau setState jika perlu
    print("Pinjam response: ${res['body']}");
  });
},


                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E2A5E),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Pinjam",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  },
);

                      },
                      child: Container(
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
                            Spacer(),
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
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    ),
  ),
);

  }

  Widget buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        Text(value, style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E2A5E),
        )),
      ],
    ),
  );
}

}


