import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sarpras_management/request.dart';
import 'package:sarpras_management/home.dart';

class HomeBottomBar extends StatelessWidget {
  final int currentIndex;
    final String token;

  const HomeBottomBar({super.key, required this.currentIndex, required this.token});

  void _navigateSafely(BuildContext context, Widget targetPage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 20,
      shadowColor: Colors.black.withOpacity(1.0),
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.grey.shade800),
              onPressed: () {
                if (currentIndex != 0) {
                  _navigateSafely(context, HomeScreen(token: token));
                }
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.chartLine, color: Colors.grey.shade800, size: 19),
              onPressed: () {
                if (currentIndex != 1) {
                  _navigateSafely(context, RequestPage(token: token));
                }
              },
            ),
            const SizedBox(width: 40), // Untuk ruang FAB
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.grey.shade800),
              onPressed: () {
                // Tambahkan navigasi jika ada halaman notifikasi
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.grey.shade800),
              onPressed: () {
                // Tambahkan navigasi jika ada halaman settings
              },
            ),
          ],
        ),
      ),
    );
  }
}
