// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/date_time_controller.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class home_page extends StatelessWidget {
  home_page({super.key});

  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'june',
    'july',
    'August',
    'september',
    'October',
    'november',
    'december',
  ];

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Weathers",
          style: GoogleFonts.wendyOne(),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://static.vecteezy.com/system/resources/thumbnails/007/922/253/small/heavy-rain-in-dark-sky-rainy-season-clouds-and-storm-weather-nature-background-flood-natural-disaster-illustration-vector.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 4,
            sigmaY: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<ApiController>(
              builder: (context, provider, _) {
                Map data = provider.data;
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: s.height * 0.1),
                        // Search City
                        TextField(
                          onSubmitted: (value) {
                            provider.weather(val: value);
                            print("+++++===================");
                            print("$data");
                            print("+++++===================");
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Search',
                            suffixIcon: IconButton(
                              onPressed: () {
                                provider.weather();
                              },
                              icon: const Icon(
                                Icons.search_outlined,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: s.height * 0.02),
                        // First Container
                        Container(
                          height: s.height * 0.38,
                          width: s.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, -1),
                                blurRadius: 3,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.outer,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today",
                                    style: GoogleFonts.wendyOne(
                                      textStyle: TextStyle(
                                        fontSize: s.height * 0.035,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${months[Provider.of<dateTimeController>(context).mon - 1]} ${Provider.of<dateTimeController>(context).mon}",
                                    style: GoogleFonts.wendyOne(
                                      textStyle: TextStyle(
                                        fontSize: s.height * 0.025,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: s.height * 0.08,
                                width: s.width,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "${data['temp']}",
                                style: GoogleFonts.wendyOne(
                                  textStyle: TextStyle(
                                    fontSize: s.height * 0.025,
                                  ),
                                ),
                              ),
                              // Highest / Lowest temp
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: s.height * 0.05,
                                        decoration: const BoxDecoration(
                                          color: Colors.black,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "https://cdn-icons-png.flaticon.com/256/116/116251.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Highest",
                                        style: GoogleFonts.wendyOne(
                                          textStyle: TextStyle(
                                            fontSize: s.height * 0.02,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: s.height * 0.01),
                                      Text(
                                        "${data['temp_max']}",
                                        style: GoogleFonts.wendyOne(
                                          textStyle: TextStyle(
                                            fontSize: s.height * 0.025,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: s.height * 0.04,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "https://www.vecteezy.com/png/10989527-cold-temperature-condition-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Lowest",
                                        style: GoogleFonts.wendyOne(
                                          textStyle: TextStyle(
                                            fontSize: s.height * 0.02,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: s.height * 0.01),
                                      Text(
                                        "${data['temp_min']}",
                                        style: GoogleFonts.wendyOne(
                                          textStyle: TextStyle(
                                            fontSize: s.height * 0.025,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: s.height * 0.02),
                        // Second Three Container
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: s.height * 0.22,
                              width: s.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Container(
                              height: s.height * 0.22,
                              width: s.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            Container(
                              height: s.height * 0.22,
                              width: s.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: s.height * 0.02),
                        // four Container
                        Container(
                          height: s.height * 0.1,
                          width: s.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, -1),
                                blurRadius: 3,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.outer,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//
// ListView.builder(
// itemCount: data.length,
// itemBuilder: (context, index) {
// print("+++++++====== $data +++++++======");
// return Text(
// data['temp'].toString(),
// );
// },
// )
