import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnPage extends StatefulWidget {
  
  final String token;
  final int peminjamanId;
  final int productId;
  const ReturnPage({super.key, required this.token, required this.peminjamanId, required this.productId});

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            Center(
              child: Text(
                'Return Page',
                style: GoogleFonts.poppins(
                  color: Color(0xFF1E2A5E),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                ),
                ),
            )
          ],
        ),
          ],
        ),
      ),
    );
  }
}