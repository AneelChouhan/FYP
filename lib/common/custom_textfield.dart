import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int? maxLength;
  List<TextInputFormatter> formatter;
  TextInputType textInputType;
  bool obsure;
  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.formatter = const [],
    this.textInputType = TextInputType.text,
    this.obsure = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsure,
      keyboardType: textInputType,
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: "",
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        hintStyle: GoogleFonts.poppins(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      style: GoogleFonts.poppins(),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter Your $hintText';
        }
        return null;
      },
      inputFormatters: formatter,
      maxLines: maxLines,
    );
  }
}
