import 'package:flutter/material.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';
import 'package:weather_app/utilse/routes_utilse.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/screens/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        AllRoutes.homePage: (context) => const home_page(),
      },
    );
  }
}
