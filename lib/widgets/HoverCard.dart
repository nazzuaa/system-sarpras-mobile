import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sarpras_management/models/product_model.dart';
import 'package:sarpras_management/models/category_model.dart';
import 'package:sarpras_management/styles.dart';

class HoverCard extends StatefulWidget {
  final Category category;
  final bool isEven;
  final int stok;

  const HoverCard({super.key, required this.category, required this.isEven, required this.stok});

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHovered
              ? const Color(0xFF11366C) // warna saat hover
              : Colors.blue.shade100.withOpacity(0.5),   // warna default
          borderRadius: BorderRadius.circular(12),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Icon(
          categoryIcons[widget.category.name.toUpperCase()] ?? FontAwesomeIcons.box,
          size: 24,
          color: isHovered ? Colors.white : Color(0xFF11366C),
        ),
        SizedBox(width: 12),
        Expanded(  // <-- Ini supaya text di Row bisa flexible dan tidak overflow
          child: Text(
            widget.category.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              color: isHovered ? Colors.white : Color(0xFF0F0F0F),
              fontWeight: FontWeight.w600,
              fontSize: 16,
               // aman jika teks panjang
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 8),
    Text(
      widget.stok.toString(),
      style: GoogleFonts.poppins(
        fontSize: 30, 
        color: isHovered ? Colors.white : Color(0xFF11366C),
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
),

      ),
    );
  }
}
