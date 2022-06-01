import 'package:flutter/material.dart';
import 'package:prepseed/views/SplashScreen.dart';
import 'package:prepseed/views/home/landingScreen.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';

import 'views/login/prepseed_loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()//SplashScreen(),
    );
  }
}
