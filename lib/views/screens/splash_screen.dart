// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utilse/routes_utilse.dart';

class splash_Screen extends StatelessWidget {
  const splash_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Navigator.of(context).pushReplacementNamed(AllRoutes.homePage);
      timer.cancel();
    });
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://i.pinimg.com/originals/8e/a3/f8/8ea3f820b1ef8cf4b04cecb098c43709.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "Welcome To Weather App",
              style: GoogleFonts.wendyOne(
                textStyle: TextStyle(
                  fontSize: s.height * 0.03,
                  shadows: const [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 7,
                      offset: Offset(2, 6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
