import 'package:app_juegos/screens/splashscreen.dart';
import 'package:app_juegos/screens/home.dart';
import 'package:app_juegos/screens/views/detail_game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home' : (BuildContext context) => Home(),
        '/detail' : (BuildContext context) => DetailScreen()
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}