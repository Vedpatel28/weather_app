import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';
import 'package:weather_app/utilse/routes_utilse.dart';

class history_page extends StatelessWidget {
  const history_page({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
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
            Map data = provider.data;
            return Column(
              children: [
                Container(
                  height: s.height * 0.8,
                  width: s.width,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: provider.listOfHistory.length,
                    itemBuilder: (context, index) => Card(
                      color: Colors.primaries[index % 18].shade200,
                      child: ListTile(
                        leading: Text(
                          " ${index + 1} ",
                          style: GoogleFonts.wendyOne(
                            textStyle: TextStyle(fontSize: s.height * 0.03),
                          ),
                        ),
                        title: Text(
                          provider.listOfHistory[index],
                          style: GoogleFonts.wendyOne(
                            textStyle: TextStyle(fontSize: s.height * 0.03),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            provider.weather(
                                val: provider.listOfHistory[index]);
                            Navigator.of(context).pushNamed(AllRoutes.homePage);
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                        ),
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
