// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/date_time_controller.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class home_page extends StatelessWidget {
  home_page({super.key});

  Connectivity connectivity = Connectivity();

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
          child: Center(
            child: StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  ConnectivityResult result =
                  snapshot.hasData as ConnectivityResult;
                  switch (result) {
                    case ConnectivityResult.mobile:
                      return Padding(
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
                                      height: s.height * 0.32,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          // date Time
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data['name']}",
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
                                          // weather Icon
                                          Container(
                                            height: s.height * 0.07,
                                            width: s.width * 0.1,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // temp / icons
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://cdn-icons-png.flaticon.com/512/3767/3767036.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Text(
                                                "   ${data['main']['temp']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.025,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://o.remove.bg/downloads/13a476e8-d6bb-4c2e-ac82-c845a1df2114/4779082-small-removebg-preview.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Highest / Lowest temp
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Highest   ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_max']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
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
                      );
                    case ConnectivityResult.wifi:
                      return Padding(
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
                                      height: s.height * 0.32,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          // date Time
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data['name']}",
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
                                          // weather Icon
                                          Container(
                                            height: s.height * 0.07,
                                            width: s.width * 0.1,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // temp / icons
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://cdn-icons-png.flaticon.com/512/3767/3767036.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Text(
                                                "   ${data['main']['temp']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.025,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://o.remove.bg/downloads/13a476e8-d6bb-4c2e-ac82-c845a1df2114/4779082-small-removebg-preview.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Highest / Lowest temp
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Highest   ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_max']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
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
                      );
                    case ConnectivityResult.ethernet:
                      return Padding(
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
                                      height: s.height * 0.32,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          // date Time
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data['name']}",
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
                                          // weather Icon
                                          Container(
                                            height: s.height * 0.07,
                                            width: s.width * 0.1,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // temp / icons
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://cdn-icons-png.flaticon.com/512/3767/3767036.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Text(
                                                "   ${data['main']['temp']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.025,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://o.remove.bg/downloads/13a476e8-d6bb-4c2e-ac82-c845a1df2114/4779082-small-removebg-preview.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Highest / Lowest temp
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Highest   ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_max']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
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
                      );
                    default:
                      return Padding(
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
                                      height: s.height * 0.32,
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
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          // date Time
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${data['name']}",
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
                                          // weather Icon
                                          Container(
                                            height: s.height * 0.07,
                                            width: s.width * 0.1,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          // temp / icons
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://cdn-icons-png.flaticon.com/512/3767/3767036.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Text(
                                                "   ${data['main']['temp']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.025,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: s.width * 0.02),
                                              Container(
                                                height: s.height * 0.08,
                                                width: s.width * 0.08,
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://o.remove.bg/downloads/13a476e8-d6bb-4c2e-ac82-c845a1df2114/4779082-small-removebg-preview.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Highest / Lowest temp
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Highest   ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_max']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min']} °",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                        s.height * 0.025,
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                        ),
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius:
                                            BorderRadius.circular(12),
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
                      );
                  }
                } else {
                  return Padding(
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
                                  height: s.height * 0.32,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      // date Time
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${data['name']}",
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
                                      // weather Icon
                                      Container(
                                        height: s.height * 0.07,
                                        width: s.width * 0.1,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              "https://static.vecteezy.com/system/resources/previews/010/989/526/original/rainy-weather-3d-rendering-isolated-on-transparent-background-ui-ux-icon-design-web-and-app-trend-png.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                      // temp / icons
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: s.height * 0.08,
                                            width: s.width * 0.08,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://cdn-icons-png.flaticon.com/512/3767/3767036.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: s.width * 0.02),
                                          Text(
                                            "   ${data['main']['temp']} °",
                                            style: GoogleFonts.wendyOne(
                                              textStyle: TextStyle(
                                                fontSize: s.height * 0.025,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: s.width * 0.02),
                                          Container(
                                            height: s.height * 0.08,
                                            width: s.width * 0.08,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://cdn-icons-png.flaticon.com/512/1779/1779940.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Highest / Lowest temp
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Highest   ",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.02,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${data['main']['temp_max']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize:
                                                    s.height * 0.025,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Lowest  ",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.02,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${data['main']['temp_min']} °",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize:
                                                    s.height * 0.025,
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: s.height * 0.22,
                                      width: s.width * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      height: s.height * 0.22,
                                      width: s.width * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                    ),
                                    Container(
                                      height: s.height * 0.22,
                                      width: s.width * 0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.4),
                                        borderRadius:
                                        BorderRadius.circular(12),
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
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
