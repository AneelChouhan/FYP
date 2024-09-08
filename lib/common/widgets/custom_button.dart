import 'package:smartfit/constants/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton(
      {super.key, required this.text, required this.onTap, this.color = GlobalVariables.selectedNavBarColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), backgroundColor: color),
      child: Text(
        text,
        style: GoogleFonts.poppins(color: color != null ?
        Colors.white : Colors.black ,fontWeight: FontWeight.bold,
        fontSize: width(context)*0.04)
      ),
    );
  }
}
