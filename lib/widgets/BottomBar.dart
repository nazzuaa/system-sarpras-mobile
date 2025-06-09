import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sarpras_management/home-page.dart';
class HomeBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0, // ✅ Ini penting untuk celah FAB
        color: Colors.white,
        elevation: 20,
         shadowColor: Colors.black,
        child: SizedBox(
          height: 65, // ✅ Pastikan tinggi cukup
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Color(0xFF11366c)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(token: 'token',)));
                },
              ),
              IconButton(
                icon: Icon(Icons.search, color: Color(0xFF11366c)),
                onPressed: () {},
              ),
              SizedBox(width: 40), // ✅ Memberi ruang tengah untuk FAB
              IconButton(
                icon: Icon(Icons.notifications, color: Color(0xFF11366c)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.settings, color: Color(0xFF11366c)),
                onPressed: () {},
              ),
            ],
          ),
        ),
    );
  }
}
