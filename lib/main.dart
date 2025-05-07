import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_routes.dart';
import 'package:flutter_application_1/homescreen.dart';
import 'package:flutter_application_1/post_view_screen.dart';
import 'package:flutter_application_1/postscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Postscreeneg(),
      routes: {
        AppRoutes.postScreen: (ctx) => Postscreeneg(),
        AppRoutes.postViewScreen: (ctx) => postviewScreen(),
      },
      // Homescreenpage(), // Replace with your actual home screen widget
    );
  }
}
