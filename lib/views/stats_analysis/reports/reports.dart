import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:prepseed/views/stats_analysis/reports/videoScreen.dart';

import 'attendenceScreen.dart';
import 'livetestScreen.dart';



class Reports extends StatefulWidget {
  const Reports({Key? key,}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: ClipPath(
              // clipper: Customshape(),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                // color: Constants.blue.withOpacity(0.7),
                child: TabBar(
                  indicatorColor: Constants.blue,
                  labelColor: Constants.white.withOpacity(0.8),
                  unselectedLabelColor: Constants.white.withOpacity(0.5),
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17
                  ),
                  tabs: const [
                    Tab(text: 'Video'),
                    Tab(text: 'Attendance'),
                    Tab(text: 'Live Test'),
                  ],
                ),
              ),
            ),
          ),
          /*AppBar(
            backgroundColor: colorpalette.backgroundColorlight.withOpacity(0.9),
            title: TabBar(
              indicatorColor: colorpalette.blue,
              labelColor: colorpalette.white,
              tabs: [
                // Tab(text: 'All Users Tasks'),
                Tab(text: 'My Tasks'),
                Tab(text: 'Tasks By Me'),
              ],
            ),
            *//*title: Text("Tasks", style: GoogleFonts.poppins(fontSize: 18,
                fontWeight: FontWeight.w500,color: colorpalette.white),),*//*
          ),*/
          body: Container(
            child: const TabBarView(
              children: [
                videoScreen(),
                attendenceScreen(),
                liveScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height-30);
    path.quadraticBezierTo(width/2, height, width, height-30);
    path.lineTo(width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}