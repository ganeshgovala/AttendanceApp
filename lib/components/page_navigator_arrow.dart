import 'package:flutter/material.dart';

class PageNavigatorArrow extends StatelessWidget {
  final onTap;
  PageNavigatorArrow({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF161616),
        ),
        child: Icon(Icons.arrow_outward_outlined, size: 18, color: Colors.white)
      ),
    );
  }
}
