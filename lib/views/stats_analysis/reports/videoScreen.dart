import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class videoScreen extends StatefulWidget {
  const videoScreen({Key? key}) : super(key: key);

  @override
  _videoScreenState createState() => _videoScreenState();
}

class _videoScreenState extends State<videoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "You haven't watched enough videos",
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
    );
  }
}
