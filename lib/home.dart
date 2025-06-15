import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/user_model.dart';
import 'package:sarpras_management/widgets/category.dart';
import 'package:sarpras_management/models/borrowing_model.dart';
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
  List<Borrowing> dipinjamList = [];
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchData();
    fetchBorrowingData();
    fetchUser();
  }

  int totalStokKategori(Category category, List<Post> products) {
  int total = 0;
  for (var p in products) {
    print('Cocokkan ${p.category?.name} dengan ${category.name}');
    if (p.category?.name == category.name) {
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
  print('Product: ${p.name}, categoryId: ${p.category?.id}, stok: ${p.stok}');
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

 
Future<void> fetchBorrowingData() async {
  setState(() => isLoading = true);
  try {
    final data = await ApiService.getBorrowings(widget.token);
    setState(() {
      // Assign hasil dari API ke pendingList
      dipinjamList = data['dipinjam']!;
      isLoading = false;
    });

    // ⬇️ CETAK KE KONSOLE UNTUK DEBUG
    print("DIPINJAM LENGTH: ${dipinjamList.length}");
    for (var item in dipinjamList) {
      print("Status: ${item.status} | Product: ${item.product?.name}");
    }

  } catch (e) {
    print("GAGALLL WOYYY: $e");
    setState(() => isLoading = false);
  }
}

Future<void> fetchUser() async {
  setState(() => isLoading = true);

  try {
    final fetchedUser = await ApiService.getUser(widget.token);
    print('User berhasil diambil: ${fetchedUser.name}');
    setState(() {
      // Assign hasil dari API ke pendingList
      user = fetchedUser;
      isLoading = false;
    });

  } catch (e) {
    print("GAGALLL WOYYY: $e");
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // Tidak menggunakan appBar biasa supaya bisa scroll bareng konten
      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.notifications_none, color: Color(0xFF11366c)),
            Text(
              "Home",
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF11366c),
              ),
            ),
            Icon(Icons.notifications_none, color: Color(0xFF11366c)),
          ],
        ),
        SizedBox(height: 25),
        RichText(
  text: TextSpan(
    style: GoogleFonts.poppins(
      fontSize: 20,
      color: Color(0xFF11366c),
    ),
    children: [
      TextSpan(
        text: 'Hi, ',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400, // Normal
        ),
      ),
      TextSpan(
        text: '${user?.name ?? ''}!',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold, // Tebal
        ),
      ),
    ],
  ),
),

        SizedBox(height: 4),
        Text(
          "Welcome back!",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 24),
        Container(
          width: 400,
          height: 40,
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
        SizedBox(height: 15),
        // Card Welcome
        Container(
          width: double.infinity,
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
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/logo-tb.png',
                  fit: BoxFit.contain,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        /// Daftar Kategori
        Text(
          "Daftar Kategori",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11366c),
          ),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            final int stok = totalStokKategori(category, products);
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
        ),

        SizedBox(height: 40),

        /// Daftar Pinjaman
        Text(
          "Daftar Pinjaman",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11366c),
          ),
        ),
        SizedBox(height: 10),
        if (isLoading)
          Center(child: CircularProgressIndicator())
        else if (dipinjamList.isEmpty)
          Center(child: Text("Belum ada peminjaman"))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dipinjamList.length,
            itemBuilder: (context, index) {
              final peminjaman = dipinjamList[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book, color: Colors.blueGrey),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${peminjaman.product?.name ?? 'Tidak diketahui'}',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Jumlah: ${peminjaman.jumlah}",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    Text(
                      "Status: ${peminjaman.status}",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                    if (peminjaman.waktuPeminjaman != null)
                      Text(
                        "Tanggal Pinjam: ${peminjaman.formattedWaktuPeminjaman}",
                        style: GoogleFonts.poppins(fontSize: 13),
                      ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 60),

      ],
    ),
  ),
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
      bottomNavigationBar: HomeBottomBar(currentIndex: 0, token: widget.token),
    );
  }
}
