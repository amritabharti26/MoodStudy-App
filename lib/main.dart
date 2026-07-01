import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mood_study_app/presentation/bindings/mood_binding.dart';
import 'package:mood_study_app/presentation/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MoodBinding(),
      home: SplashScreen(),
    );
  }
}
