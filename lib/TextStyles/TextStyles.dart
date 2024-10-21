import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textstyles {

  TextStyle subHeading(Color color) {
    return GoogleFonts.figtree(
      textStyle: TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      )
    );
  }

  TextStyle boldTextStyle(double fontSize, Color color) {
    return GoogleFonts.figtree(
      textStyle: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
      )
    );
  }

  TextStyle buttonTextStyle() {
    return GoogleFonts.figtree(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 22, 22, 22),
    );
  }
}
