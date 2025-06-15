import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/borrowing.dart';
import 'package:sarpras_management/models/borrowing_model.dart';
import 'package:sarpras_management/services/api_service.dart';
import 'dart:convert';

import 'package:sarpras_management/widgets/BottomBar.dart';

class RequestPage extends StatefulWidget {
  
  final String token;
  const RequestPage({super.key, required this.token});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<Borrowing> pendingList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBorrowingData();
  }

  Future<void> fetchBorrowingData() async {
  setState(() => isLoading = true);
  try {
    final data = await ApiService.getBorrowings(widget.token);
    setState(() {
      // Assign hasil dari API ke pendingList
      pendingList = data['pending']!;
      isLoading = false;
    });

    // ⬇️ CETAK KE KONSOLE UNTUK DEBUG
    print("PENDING LENGTH: ${pendingList.length}");
    for (var item in pendingList) {
      print("Status: ${item.status} | Product: ${item.product?.name}");
    }

  } catch (e) {
    print("GAGALLL WOYYY: $e");
    setState(() => isLoading = false);
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFF11366c),
            padding: EdgeInsets.only(top: 14, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Aktivitas Saya",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BorrowingPage(token: widget.token),
                          ),
                        );
                      },
                      child: Text(
                        "Sedang Proses",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "Dalam Permintaan",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                // Container(
                //   height: 3,
                //   width: MediaQuery.of(context).size.width / 2.5,
                //   color: Colors.white,
                //   alignment: Alignment.bottomLeft,
                // ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                  if (isLoading)
                    Center(child: CircularProgressIndicator())
                  else if (pendingList.isEmpty)
                    Center(child: Text("Belum ada peminjaman"))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pendingList.length,
                      itemBuilder: (context, index) {
                        final peminjaman = pendingList[index];
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Peminjam: ${peminjaman.user?.name ?? 'Tidak diketahui'}",
                                style: GoogleFonts.poppins(fontSize: 13),
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
                              if (peminjaman.batasPengembalian != null)
                                Text(
                                  "Batas Kembali: ${peminjaman.formattedBatasPengembalian}",
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => CreateRequestPage()),
          // );
        },
        backgroundColor: Color(0xFF11366c),
        foregroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(bottom: 2, right: 4),
          child: Icon(FontAwesomeIcons.handsHolding, size: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomeBottomBar(currentIndex: 1, token: widget.token),
    );
  }
}