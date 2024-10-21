// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget {

  final TextEditingController controller;
  final String hintText;
  bool obsecureText;

  InputField({
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    super.key
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(1, 1),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(225, 179, 179, 179),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        obscureText: widget.obsecureText,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.hintText == "Password" 
                      ? GestureDetector(
                        onTap: () {
                          if(widget.hintText == "Password") {
                            setState(() {
                              widget.obsecureText = !widget.obsecureText;
                            });
                          }
                        },
                        child: (widget.obsecureText ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined)))
                      : Text(""),
          prefixIcon: widget.hintText == "Email" ? 
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 6),
                        child: Icon(Icons.email_outlined, size: 24, color: const Color.fromARGB(255, 48, 48, 48)),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 6),
                        child: Icon(Icons.lock_outline, size: 22, color: const Color.fromARGB(255, 48, 48, 48)),
                      ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.figtree(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 50, 50, 50),
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        ),
        style: GoogleFonts.figtree(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: const Color.fromARGB(255, 18, 18, 18)
        )
      ),
    );
  }
}