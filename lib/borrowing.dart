import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/borrowing_model.dart';
import 'package:sarpras_management/request.dart';
import 'package:sarpras_management/return.dart';
import 'package:sarpras_management/services/api_service.dart';
import 'dart:convert';

import 'package:sarpras_management/widgets/BottomBar.dart';

class BorrowingPage extends StatefulWidget {
  
  final String token;
  const BorrowingPage({super.key, required this.token});

  @override
  State<BorrowingPage> createState() => _BorrowingPageState();
}

class _BorrowingPageState extends State<BorrowingPage> {
   List<Borrowing> dipinjamList = [];
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
      dipinjamList = data['dipinjam']!;
      isLoading = false;
    });

    // ⬇️ CETAK KE KONSOLE UNTUK DEBUG
    print("PENDING LENGTH: ${dipinjamList.length}");
    for (var item in dipinjamList) {
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
                    Text(
                      "Sedang Proses",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestPage(token: widget.token),
                          ),
                        );
                      },
                      child: Text(
                        "Dalam Permintaan",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: 12,
                        ),
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
                  else if (dipinjamList.isEmpty)
                    Center(child: Text("Belum ada peminjaman"))
                  else
                   ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: dipinjamList.length,
  itemBuilder: (context, index) {
    final peminjaman = dipinjamList[index];
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white),
      ),
      child: ExpansionTile(
        title: Text(
          '${peminjaman.product?.name ?? 'Tidak diketahui'}',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.book, color: Colors.blueGrey),
        childrenPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.circleCheck, color: Colors.green, size: 14,),
                  SizedBox(width: 8),
                  Text(
                    peminjaman.status,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Padding(
                    padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_sharp, size: 14),
                  SizedBox(width: 8),
                  Text(
                   peminjaman.formattedWaktuPeminjaman,
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                    )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),


Padding(
  padding: EdgeInsets.symmetric(horizontal: 1),
  child: Divider(
    color: Colors.grey.shade300,
    thickness: 1,
  ),
),
SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                    Icon(Icons.calendar_today_sharp, size: 14),
                  SizedBox(width: 8),
                  Text(
                  'Jumlah Barang',
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                       color: Colors.grey.shade500
                    )
                    ),
                  ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        '${peminjaman.jumlah}',
                        style: GoogleFonts.poppins(
                       fontSize: 14,
                    )
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                    Icon(FontAwesomeIcons.clock, size: 14, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                  'Batas Pengembalian',
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                       color: Colors.grey.shade500
                    )
                    ),
                  ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        peminjaman.formattedBatasPengembalian,
                        style: GoogleFonts.poppins(
                       fontSize: 14,
                    )
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                    Icon(Icons.location_pin, size: 14,),
                  SizedBox(width: 8),
                  Text(
                  'Lokasi Pinjam',
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                       color: Colors.grey.shade500
                    )
                    ),
                  ],
                      ),
                      SizedBox(height: 5),
                      Text(
                          peminjaman.user?.kelas?.name ?? 'Lokasi tidak diketahui',
                        style: GoogleFonts.poppins(
                       fontSize: 14,
                    )
                      ),
                    ],
                  ),

                   SizedBox(height: 10),

// ⬇️ Tambahkan garis di sini
Padding(
  padding: EdgeInsets.symmetric(horizontal: 1),
  child: Divider(
    color: Colors.grey.shade300,
    thickness: 1,
  ),
),
SizedBox(height: 10),

 Text(
                  'Lokasi Barang',
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                       color: Colors.grey.shade500
                    )
                    ),
                      SizedBox(height: 5),
                      Text(
                          peminjaman.product?.location?.name ?? 'Lokasi tidak diketahui',
                        style: GoogleFonts.poppins(
                       fontSize: 14,      
                        )
                      ),
SizedBox(height: 10),

 Text(
                  'Lokasi Barang',
                    style: GoogleFonts.poppins(
                       fontSize: 14,
                       color: Colors.grey.shade500
                    )
                    ),
                      SizedBox(height: 5),
                      Text(
                          peminjaman.product?.location?.name ?? 'Lokasi tidak diketahui',
                        style: GoogleFonts.poppins(
                       fontSize: 14,      
                        )
                      ),
                      SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                 onPressed: () {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReturnPage( token: widget.token,
          peminjamanId: peminjaman.id,
          productId: peminjaman.product!.id,)),
    );
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
                    "Kembalikan",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
                  
            ],
          )
        ],
      ),
    );
  },
)

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