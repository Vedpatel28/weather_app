import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';

class home_page extends StatelessWidget {
  const home_page({super.key});

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/originals/3d/34/93/3d3493584dcf101224113ce13f8163e6.png",
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
                  child: Column(
                    children: [
                      SizedBox(height: s.height * 0.1),
                      TextField(
                        onSubmitted: (value) {
                          provider.weather(val: value);
                        },
                      ),
                      SizedBox(height: s.height * 0.02),
                      Container(
                        height: s.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(2, 0),
                              blurRadius: 8,
                              spreadRadius: 6,
                              blurStyle: BlurStyle.outer,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            print("+++++++====== $data +++++++======");
                            return Text(
                              data['temp'].toString(),
                            );
                          },
                        ),
                      ),
                    ],
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
