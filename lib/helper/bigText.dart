import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class bigText extends StatelessWidget {
  final String text;
  final Color color;
  double size = 45;
   bigText({Key? key, required this.text, required this.color,required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.poppins(fontSize: size, color: color),);
  }
}
