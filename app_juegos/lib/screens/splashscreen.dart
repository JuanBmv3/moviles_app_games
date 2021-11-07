import 'package:app_juegos/screens/home.dart';
import 'package:flutter/material.dart';


import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: Home(),
      duration: 8000,
      imageSrc: 'assets/game.gif',
      imageSize: 200,
      text: 'Games App',
      backgroundColor: Colors.black87,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue[800]),
    );
    
  }
}