import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/init/InitializeProviderScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/strings.dart';
import '../constants/colorPalate.dart';
import 'home/landingScreen.dart';
import 'login/company_signIn_signUp.dart';
import 'login/login.dart';
import 'login/prepseed_loginScreen.dart';

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
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();
    timer();
    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen())));
  }

  dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void> timer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username');
    var InstituteName = prefs.getString('InstituteName');
    var InstituteLogo = prefs.getString('InstituteLogo');

    print(username);
    print(InstituteName);
    print(InstituteLogo);

    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) =>
        ((InstituteName == null) || (InstituteLogo == null) || (username == null)) ? prepSeed_login() :
        (username == null || username == '') ? signIn_signUp(clientname: InstituteName,clientlogo: InstituteLogo,) :
        landingScreen()  )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
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
                        Image.asset('assets/images/logo.png')
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