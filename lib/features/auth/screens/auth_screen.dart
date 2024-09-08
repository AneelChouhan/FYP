// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/constants/utils.dart';
import 'package:smartfit/features/admin/screens/admin_screen.dart';
import 'package:smartfit/features/auth/screens/forgetpassword.dart';
import 'package:smartfit/features/auth/screens/sinup.dart';
import 'package:smartfit/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/custom_textfield.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../main.dart';
import 'loginsignuphelper.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void>  signInUser() async {
    if (_emailController.text == 'admin@admin.com' &&
        _passwordController.text == 'admin') {
      await prefs.setString('u', 'admin');
      await prefs.setString('id', 'admin');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const AdminScreen(),
        ),
        (route) => false,
      );
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        authService.signInUser(
          context: context,
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        showSnackBar(context, "Email is not valid");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              logsighelper(
                text1: 'Log',
                text2: 'in',
                text3:
                    'Welcome back, please login to your account to continue using our app',
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: GlobalVariables.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        obsure: true,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 10),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: InkWell(
                      //     onTap: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => const forgetpassword(),
                      //       ));
                      //     },
                      //     child: Text(
                      //       "Forget Password",
                      //       style: GoogleFonts.poppins(),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _emailController.clear();
                          _passwordController.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const singup(),
                          ));
                        },
                        child: Text(
                          "Not Have A Account",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Log In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
