import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/strings.dart';
import '../constants/colorPalate.dart';
import 'home/landingScreen.dart';
import 'login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? animation;

  @override
   initState()  {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
    timer();
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen())));
  }

  dispose() {
    controller!.dispose(); // you need this
    super.dispose();
  }

  Future<void> timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var last_name = prefs.getString('last_name');

    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => (username == null || username == '') ? LoginPage() : landingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColorTrans,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                  opacity: animation!,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Image.asset('assets/images/logo.jpg')
                      ]
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}