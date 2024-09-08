// ignore_for_file: must_be_immutable, camel_case_types

import 'package:smartfit/constants/globals_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class logsighelper extends StatelessWidget {
  logsighelper(
      {Key? key, required this.text1, required this.text2, required this.text3})
      : super(key: key);
  String text1, text2, text3;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context) * 0.35,
      child: Column(
        children: [
          Image.asset(
            'assets/logo.png',
            width: width(context) * 0.3,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text1,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                        fontSize: width(context) * 0.1),
                  ),
                  Text(
                    text2,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: width(context) * 0.1,
                        color: GlobalVariables.selectedNavBarColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width(context) * 0.1),
              child: Text(
                text3,
                style: GoogleFonts.poppins(
                    fontSize: width(context) * 0.04),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}