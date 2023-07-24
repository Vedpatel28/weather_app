import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class like_page extends StatelessWidget {
  const like_page({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: Colors.transparent),
        title: Text("Saved", style: GoogleFonts.wendyOne()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<ApiController>(
          builder: (context, provider, _) {
            return Column(
              children: [
                Container(
                  height: s.height * 0.8,
                  child: ListView.builder(
                    itemCount: provider.likedTemp.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.primaries[index % 18],
                        child: ListTile(
                          leading: Text(
                            "${index + 1}",
                            style: GoogleFonts.wendyOne(
                              textStyle: TextStyle(
                                fontSize: s.height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            "Temp : ${provider.likedTemp[index]}"
                                .substring(0, 12),
                            style: GoogleFonts.wendyOne(
                              textStyle: TextStyle(
                                fontSize: s.height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "City : ${provider.likedName[index]}",
                            style: GoogleFonts.wendyOne(
                              textStyle: TextStyle(
                                fontSize: s.height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
