import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class history_page extends StatelessWidget {
  const history_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: Colors.transparent),
        title: Text("History", style: GoogleFonts.wendyOne()),
        centerTitle: true,
      ),
    );
  }
}
