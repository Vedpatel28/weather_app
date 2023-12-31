import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/controllers/date_time_controller.dart';
import 'package:weather_app/controllers/weather_api_controller.dart';
import 'package:weather_app/utilse/routes_utilse.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/screens/history_page.dart';
import 'package:weather_app/views/screens/home_page.dart';
import 'package:weather_app/views/screens/like_page.dart';
import 'package:weather_app/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              ApiController(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (context) => dateTimeController(),
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
      initialRoute: AllRoutes.splashScreen,
      routes: {
        AllRoutes.homePage: (context) => home_page(),
        AllRoutes.splashScreen: (context) => splash_Screen(),
        AllRoutes.historyPage: (context) => history_page(),
        AllRoutes.likePage: (context) => like_page(),
      },
    );
  }
}
