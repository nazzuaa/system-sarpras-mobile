import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/widgets/BottomBar.dart';

class HomePage extends StatefulWidget{
  @override


 final String token;
const HomePage({super.key,required this.token});
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState  extends State<HomePage> {
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF1E2A5E),
    body: Column(
      children: [
        // Bagian ungu (Header)
        Container(
          height: 200,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/header1.jpg'), // ganti sesuai lokasi gambarmu
      fit: BoxFit.cover,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // AppBar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                  "Hi, Ayana Tiana!",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
                    
                    Row(
                      children: const [
                        Icon(Icons.calendar_month_rounded, color: Colors.white),
                        SizedBox(width: 12),
                        Icon(Icons.notifications_none, color: Colors.white),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 55),
                SizedBox(
                      width: 300,
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
                          prefixIcon: Icon(Icons.search, color: Colors.white, size: 16,),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),

                // Text(
                //   "Hi, Ayana Tiana!",
                //   style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                // ),
                // const SizedBox(height: 5),
                // Text(
                //   "Want to borrow?",
                //   style: GoogleFonts.poppins(color: Colors.grey.shade300, fontSize: 14),
                // ),
              ],
            ),
          ),
        ),

        // Bagian Putih Scrollable
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            ),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Horizontal scroll kategori
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                    buildCategory("TU", Icons.ad_units_rounded ),
                    buildCategory("Olahraga", Icons.build),
                    buildCategory("UKS", Icons.book),
                    buildCategory("Sarpras", Icons.more_horiz),
                    buildCategory("Gudang", Icons.more_horiz),
                    buildCategory("Musolla", Icons.more_horiz),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, // biar semua isi rata kiri
    children: [
      Row(
        children: [
          Text(
            "Recent Activity",
            style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            )
          ),
           SizedBox(width: 8),
          Icon(FontAwesomeIcons.clockRotateLeft, size: 18,),
        ],
      ),
      // Judul Recent Activity
    //   Row(
    // children: [ 
    //   child: Text(
    //       "Recent Activity",
    //       style: GoogleFonts.poppins(
    //         fontSize: 22,
    //         fontWeight: FontWeight.w700,
    //       ),
    //     ),
      
    //   )],
      SizedBox(height: 15,),
      Column(
          children: [
            // Aktivitas 1
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.book, color: Colors.blueGrey),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Borrowed Book: Flutter Guide",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      
    ],
  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
 floatingActionButton: FloatingActionButton(
  onPressed: () {},
  backgroundColor: Colors.black,
  foregroundColor: Colors.yellow,
  child: Icon(Icons.add),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
bottomNavigationBar: HomeBottomBar(),

  );
}

// Widget kategori
Widget buildCategory(String label, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Color(0xFF1E2A5E)),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.poppins(fontSize: 15)),
      ],
    ),
  );
}

}