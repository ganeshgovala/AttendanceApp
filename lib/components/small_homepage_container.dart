import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallHomepageContainer extends StatelessWidget {
  final IconData icon;
  final String heading;
  final Color color;
  const SmallHomepageContainer({
    required this.color,
    required this.icon,
    required this.heading,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            SizedBox(width: 10),
            Text(heading,
                style: GoogleFonts.ubuntu(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}
