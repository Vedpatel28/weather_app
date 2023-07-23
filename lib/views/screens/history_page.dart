import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class history_page extends StatelessWidget {
  const history_page({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.transparent,
        ),
        title: Text(
          "History",
          style: GoogleFonts.wendyOne(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<ApiController>(
          builder: (context, provider, _) {
            return Column(
              children: [
                Container(
                  height: s.height * 0.5,
                  width: s.width,
                  color: Colors.grey,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: provider.historySearch.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(
                        provider.listOfHistory[index],
                        style: GoogleFonts.wendyOne(),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
