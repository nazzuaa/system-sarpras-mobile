import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/category_page/elektronik.dart';
import 'package:sarpras_management/models/category_model.dart';
import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/services/api_service.dart';
import 'package:sarpras_management/widgets/BottomBar.dart';
import 'dart:convert';

import 'package:sarpras_management/widgets/HoverCard.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> products = [];
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  int totalStokKategori(Category category, List<Post> products) {
  int total = 0;
  for (var p in products) {
    print('Cocokkan ${p.category.name} dengan ${category.name}');
    if (p.category.name == category.name) {
      total += p.stok;
    }
  }
  return total;
}





  Future<void> fetchData() async {
  setState(() => isLoading = true);
  try {
    final fetchedCategories = await ApiService.getCategories(widget.token);
    final fetchedProducts = await ApiService.getProducts(widget.token);
for (var p in fetchedProducts) {
  print('Product: ${p.name}, categoryId: ${p.category.id}, stok: ${p.stok}');
}


    setState(() {
      categories = fetchedCategories;
      products = fetchedProducts;
      isLoading = false;
    });
  } catch (e) {
    print("Error fetching data: $e");
    setState(() => isLoading = false);
  }
}

 




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tidak menggunakan appBar biasa supaya bisa scroll bareng konten
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false, // supaya bisa scroll hilang
            floating: false,
            snap: false,
            expandedHeight: 40,
            backgroundColor: Colors.white,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.notifications_none, color: Color(0xFF11366c)),
                    Text(
                      "Home",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF11366c),
                      ),
                    ),
                    Icon(Icons.notifications_none, color: Color(0xFF11366c)),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  "Hi, Tiana Keyla!",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF11366c),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Welcome back!",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 400,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Color(0xFF1E2A5E),
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xFF11366c)),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: 300,
                  height: 120,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFF11366c), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Text section
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome!",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF11366c),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Let's schedule your projects",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Image section (placeholder)
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/logo-tb.png', // Ganti dengan path gambarmu
                          fit: BoxFit.contain,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),

          // Grid produk sebagai SliverGrid
          isLoading
              ? SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Text(
                      "Daftar Barang",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF11366c),
                      ),
                    ),
                  ),
                ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5, // Ubah ini untuk kontrol tinggi card
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = categories[index];
                  final int stok = totalStokKategori(category, products);
                  // print('Kategori: ${category.name}, Stok total: $stok');
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElektronikScreen(
                            token: widget.token,
                            categoryId: category.id,
                            categoryName: category.name,
                          ),
                        ),
                      );
                    },
                    child: HoverCard(
                      category: category,
                      isEven: index % 2 == 0,
                      stok: stok,
                    ),
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
              child: Text(
                "Daftar Barang",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          //   sliver: isLoading
          //       ? SliverToBoxAdapter(
          //           child: Center(child: CircularProgressIndicator()),
          //         )
          //       : SliverList(
          //           delegate: SliverChildBuilderDelegate(
          //             (context, index) {
          //               final product = products[index];
          //               return Container(
          //                 margin: EdgeInsets.only(bottom: 10),
          //                 padding: EdgeInsets.all(10),
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: Colors.grey.shade300),
          //                   borderRadius: BorderRadius.circular(12),
          //                 ),
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.book, color: Colors.blueGrey),
          //                     SizedBox(width: 12),
          //                     Expanded(
          //                       child: Text(
          //                         "Borrowed: ${product.name}",
          //                         style: GoogleFonts.poppins(fontSize: 14),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //             childCount: products.length,
          //           ),
          //         ),
          // ),

          // Spacer agar tidak tertutup FAB
          SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //       Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CreateRequestPage()),
          // );
        },
        backgroundColor: Color(0xFF11366c),
        foregroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2, right: 4), // naikkan sedikit
          child: Icon(
            FontAwesomeIcons.handsHolding,
            size: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
