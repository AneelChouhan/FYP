import 'dart:async';

import 'package:smartfit/constants/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smartfit/features/store/storehome.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../main.dart';
import '../../admin/screens/admin_screen.dart';
import 'auth_screen.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => prefs.containsKey('u')?
        prefs.getString('u') == 'User' ? const BottomBar() :
        prefs.getString('u') == 'admin' ? const AdminScreen() :
        prefs.getString('u') == 'Store' ? const storehome() :
        const AuthScreen():const AuthScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Image.asset('assets/logo.png'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Smart',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: width(context) * 0.15),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Fit',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: width(context) * 0.15,
                        color: GlobalVariables.selectedNavBarColor),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Text(
                'A place where you can buy clothes',
                style: GoogleFonts.roboto(
                    fontSize: width(context) * 0.04),
                textAlign: TextAlign.left,
              ),
              Lottie.asset(
                'assets/loading.json',
                width: width(context)*0.7,
                repeat: true,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
