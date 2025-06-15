import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/history_model.dart';
import 'package:sarpras_management/request.dart';
import 'package:sarpras_management/services/api_service.dart';

class HistoriesScreen extends StatefulWidget {
  final String token;
  const HistoriesScreen({super.key, required this.token});

  @override
  State<HistoriesScreen> createState() => _HistoriesScreenState();
}

class _HistoriesScreenState extends State<HistoriesScreen> {
  List<History> historyList = [];
  bool isLoading = true;

  @override
   void initState() {
    super.initState();
    fetchHistoriesData();
  }

   Future<void> fetchHistoriesData() async {
  setState(() => isLoading = true);
       try {
    final fetchedHistories = await ApiService.getHistories(widget.token);

      setState(() {
      historyList = fetchedHistories;
      isLoading = false;
    });

       } catch (e){
        print("Error fetching data: $e");
    setState(() => isLoading = false);
       }
   }


  @override
  Widget build(BuildContext context){
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
                            builder: (context) => RequestPage(token: widget.token),
                          ),
                        );
                      },
                      child: Text(
                        "Dalam Proses",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "Riwayat",
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
          SizedBox(height: 10),
          Expanded(
  child: isLoading
      ? Center(child: CircularProgressIndicator())
      : historyList.isEmpty
          ? Center(child: Text("Belum ada riwayat"))
          : ListView.builder(
              itemCount: historyList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final history = historyList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  history.product?.name ?? 'Produk tidak diketahui',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.verified, color: Colors.green, size: 18),
                              ],
                            ),
                            Icon(Icons.chevron_right, color: Colors.black54),
                          ],
                        ),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Gambar Produk
                            Image.network(
                              history.imageUrl, // Pastikan ini URL gambar valid
                              width: 100,
                              height: 60,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
                            ),
                            SizedBox(width: 12),
                            // Deskripsi
                            Expanded(
                              child: Text(
                                "${history.note} - ${history.product?.name ?? '-'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
)


        ]
      )
    );
  }
}