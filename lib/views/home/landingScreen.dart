import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:prepseed/main.dart';
import 'package:prepseed/model/menuItem.dart';
import 'package:prepseed/views/adventure/liveTest.dart';
import 'package:prepseed/views/execute/practice/practice.dart';
import 'package:prepseed/views/execute/test/test_.dart';
import 'package:prepseed/views/home/mainScreen.dart';
import 'package:prepseed/views/learn/assignments.dart';
import 'package:prepseed/views/learn/documents.dart';
import 'package:prepseed/views/learn/videos.dart';
import 'package:prepseed/views/menu/menu.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';
import 'package:prepseed/views/execute/quantized_sheet/quantized_sheet.dart';
import 'package:prepseed/views/execute/test/tests.dart';
import 'package:prepseed/views/home/mainScreen.dart';
import 'package:prepseed/views/login/prepseed_loginScreen.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prepseed/views/stats_analysis/reports/reports.dart';

class landingScreen extends StatefulWidget {
  const landingScreen({Key? key}) : super(key: key);

  @override
  _landingScreenState createState() => _landingScreenState();
}

class _landingScreenState extends State<landingScreen> {
  final _drawerController = ZoomDrawerController();
  MainMenuItems currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _drawerController,
        style: DrawerStyle.Style1,
        menuScreen: Builder(
          builder: (context) =>
              MenuScreen(
                  currentItem: currentItem,
                  onSelectedItem: (item) {
                    setState(() {
                      currentItem = item;
                    });
                    ZoomDrawer.of(context)!.close();
                  }
              ),
        ),
        mainScreen: getScreen(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0.0,
        // clipMainScreen: true,
        // backgroundColor: Colors.grey,
        slideWidth: MediaQuery
            .of(context)
            .size
            .width * 0.65,
        //(ZoomDrawer.isRTL() ? .45 :
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home :
        return mainScreen();
      case MenuItems.analysis :
        return Analysis();
      case MenuItems.reports :
        return Reports();
      case MenuItems.videos :
        return livetest();
      case MenuItems.documents :
        return documents();
      case MenuItems.assignments :
        return assignments();
      case MenuItems.practice :
        return practice();
      case MenuItems.quantizedSheet :
        return quantized_sheet();
/*      case MenuItems.logout:
        return logout();*/
      case MenuItems.Tests :
      default:
        return test();
    }
  }



}
