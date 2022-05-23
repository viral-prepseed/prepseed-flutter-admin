import 'package:flutter/material.dart';
import 'package:prepseed/views/home/mainScreen.dart';
import 'package:prepseed/views/stats_analysis/analysis/analysis.dart';
import 'package:prepseed/views/stats_analysis/reports/reports.dart';

import '../../constants/colorPalate.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.grey,
                  Colors.grey,
                ],
              )
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 70),
            children: <Widget>[

              // Text('Dashboard'),
              ListTile(
                title: Text("Home", style: GoogleFonts.poppins(color: Constants.black,),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mainScreen()));
                },
              ),
              ListTile(
                title: Text("Analysis", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Analysis()));
                },
              ),
              ListTile(
                title: Text("Reports", style: TextStyle(color: Constants.black,)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Reports()));
                },
              ),
              ListTile(
                title: Text("videos", style: TextStyle(color: Constants.black,)),
              ),
              ListTile(
                title: Text("Documents", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("Assignments", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("Quantized Sheet", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("Tests", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              SizedBox(
                height:
                20.0,
              ),
              Divider(
                color: Colors.blue[100],
                thickness: 1,
              ),
              SizedBox(
                height:
                20.0,
              ),
              ListTile(
                title: Text("Contact Us", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              ListTile(
                title: Text("About Us", style: TextStyle(color: Constants.black,)),
                onTap: () {
                },
              ),
              Container(
                margin: EdgeInsets.only(right: 300.0),
                child: ListTile(
                  tileColor: Constants.black,
                  title: Text("Logout", style: TextStyle(color: Colors.red,)),
                  // onTap: () => _handleLogout(context)

                ),
              ),
              SizedBox(
                height:
                20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
