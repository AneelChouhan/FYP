import 'package:flutter/material.dart';
import 'package:smartfit/constants/utils.dart';

import '../../../common/custom_textfield.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../constants/globals_variable.dart';
import '../services/auth_service.dart';
import 'loginsignuphelper.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({super.key});

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  Future<void> signInUser() async {
    String? n = validatePassword(_passwordController.text);
    if(_passwordController.text != _confirmpasswordController.text) {
      showSnackBar(context, "Passwords do not match");
    } else if (n != null) {
      showSnackBar(context, n);
    } else {
      authService.forgetpassword(
        context,_emailController.text,_passwordController.text
      );
    }
  }


  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase, one lowercase, one number, and one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            logsighelper(
              text1: 'Change',
              text2: 'Password',
              text3:
              'Be careful! While changing your password.',
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
                      hintText: 'current Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      obsure: true,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _confirmpasswordController,
                      obsure: true,
                      hintText: 'Confirm Password',
                    ),
                    const SizedBox(height: 10,),
                    CustomButton(
                        text: 'Change Password',
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
    );
  }
}
