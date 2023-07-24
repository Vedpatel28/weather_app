// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/date_time_controller.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';
import 'package:weather_app/utilse/routes_utilse.dart';

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
        leading: const Icon(Icons.add, color: Colors.transparent),
        title: Text(
          "Weathers",
          style: GoogleFonts.wendyOne(),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                "${months[Provider.of<dateTimeController>(context).mon - 1]} ${Provider.of<dateTimeController>(context).date}",
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
                                                "   ${data['main']['temp'] - 275} °"
                                                    .substring(0, 5),
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
                                                    "${data['main']['temp_max'] - 275} °"
                                                        .substring(0, 5),
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
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min'] - 275} °"
                                                        .substring(0, 5),
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
                                    // Second Container
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.932,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Country : ${data['sys']['country']}..",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.022,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: s.height * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/6368/6368753.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['feels_like'] - 275}".substring(0, 5),
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/1779/1779940.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['main']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: s.height * 0.01),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://forums.synfig.org/uploads/default/original/2X/3/31d749625faa93271be23874d416f9be755b7cb9.gif",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['description']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://www.shareicon.net/data/512x512/2017/04/19/884240_weather_512x512.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['humidity']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  )
                                                ],
                                              ),
                                            ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(AllRoutes.homePage);
                                            },
                                            icon: const Icon(
                                              Icons.home,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                AllRoutes.historyPage,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.history,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              provider.Saved(
                                                temp: data['main']['temp'] - 275,
                                                name: data['name'],
                                              );
                                              Navigator.of(context).pushNamed(AllRoutes.likePage);
                                            },
                                            icon: const Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.black,
                                            ),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                "${months[Provider.of<dateTimeController>(context).mon - 1]} ${Provider.of<dateTimeController>(context).date}",
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
                                                "   ${data['main']['temp'] - 275} °"
                                                    .substring(0, 5),
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
                                                    "${data['main']['temp_max'] - 275} °"
                                                        .substring(0, 5),
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
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min'] - 275} °"
                                                        .substring(0, 5),
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
                                    // Second Container
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.932,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Country : ${data['sys']['country']}..",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.022,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: s.height * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/6368/6368753.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['feels_like'] - 275}".substring(0, 5),
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/1779/1779940.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['main']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: s.height * 0.01),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://forums.synfig.org/uploads/default/original/2X/3/31d749625faa93271be23874d416f9be755b7cb9.gif",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['description']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://www.shareicon.net/data/512x512/2017/04/19/884240_weather_512x512.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['humidity']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  )
                                                ],
                                              ),
                                            ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(AllRoutes.homePage);
                                            },
                                            icon: const Icon(
                                              Icons.home,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                AllRoutes.historyPage,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.history,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              provider.Saved(
                                                temp: data['main']['temp'] - 275,
                                                name: data['name'],
                                              );
                                              Navigator.of(context).pushNamed(AllRoutes.likePage);
                                            },
                                            icon: const Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.black,
                                            ),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                "${months[Provider.of<dateTimeController>(context).mon - 1]} ${Provider.of<dateTimeController>(context).date}",
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
                                                "   ${data['main']['temp'] - 275} °"
                                                    .substring(0, 5),
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
                                                    "${data['main']['temp_max'] - 275} °"
                                                        .substring(0, 5),
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
                                                  Text(
                                                    "Lowest  ",
                                                    style: GoogleFonts.wendyOne(
                                                      textStyle: TextStyle(
                                                        fontSize: s.height * 0.02,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['temp_min'] - 275} °"
                                                        .substring(0, 5),
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
                                    // Second Container
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: s.height * 0.22,
                                          width: s.width * 0.932,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.4),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Country : ${data['sys']['country']}..",
                                                style: GoogleFonts.wendyOne(
                                                  textStyle: TextStyle(
                                                    fontSize: s.height * 0.022,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: s.height * 0.02,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/6368/6368753.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['feels_like'] - 275}".substring(0, 5),
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://cdn-icons-png.flaticon.com/512/1779/1779940.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['main']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: s.height * 0.01),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://forums.synfig.org/uploads/default/original/2X/3/31d749625faa93271be23874d416f9be755b7cb9.gif",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['weather'][0]['description']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  ),
                                                  Container(
                                                    height: s.height * 0.06,
                                                    width: s.width * 0.1,
                                                    decoration: const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          "https://www.shareicon.net/data/512x512/2017/04/19/884240_weather_512x512.png",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data['main']['humidity']}",
                                                    style: GoogleFonts.wendyOne(),
                                                  )
                                                ],
                                              ),
                                            ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed(AllRoutes.homePage);
                                            },
                                            icon: const Icon(
                                              Icons.home,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                AllRoutes.historyPage,
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.history,
                                              color: Colors.black,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              provider.Saved(
                                                temp: data['main']['temp'] - 275,
                                                name: data['name'],
                                              );
                                              Navigator.of(context).pushNamed(AllRoutes.likePage);
                                            },
                                            icon: const Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.black,
                                            ),
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
                      return const CircularProgressIndicator();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
