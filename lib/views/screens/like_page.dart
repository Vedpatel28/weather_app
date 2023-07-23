import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class like_page extends StatelessWidget {
  const like_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: Colors.transparent),
        title: Text("Saved", style: GoogleFonts.wendyOne()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<ApiController>(builder: (context, provider, _) {
          return Column(
            children: [
              // Text("${provider.getWeather[0].temp}"),
            ],
          );
        }),
      ),
    );
  }
}
