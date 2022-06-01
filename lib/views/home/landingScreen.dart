import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:prepseed/views/home/mainScreen.dart';
import 'package:prepseed/views/menu/menu.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';

class landingScreen extends StatefulWidget {
  const landingScreen({Key? key}) : super(key: key);

  @override
  _landingScreenState createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> {
  final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style1,
        menuScreen: MenuScreen(),
        mainScreen: mainScreen(zoomController: _drawerController, ),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        // clipMainScreen: true,
        // backgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width *  0.65, //(ZoomDrawer.isRTL() ? .45 :
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}
