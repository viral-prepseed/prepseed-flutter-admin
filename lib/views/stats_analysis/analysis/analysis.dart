import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prepseed/constants/colorPalate.dart';
import 'package:prepseed/views/menu/menu_widget.dart';
import 'package:prepseed/views/stats_analysis/analysis/testlevel.dart';

import 'overall.dart';


class Analysis extends StatefulWidget {
  const Analysis({Key? key,}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        leading: MenuWidget(),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              child: TabBar(
                indicatorColor: Constants.blue,
                labelColor: Constants.white.withOpacity(0.8),
                unselectedLabelColor: Constants.white.withOpacity(0.5),
                labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                ),
                tabs: const [
                  Tab(text: 'Overall'),
                  Tab(text: 'Test Level'),
                ],
              ),
            ),
            Expanded(
              child: const TabBarView(
                children: [
                  // allUserTasks(),
                  overall(),
                  testLevel(),
                ],
              ),
            ),
          ],
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
    return true;
  }
}