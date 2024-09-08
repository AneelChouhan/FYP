import 'package:smartfit/constants/globals_variable.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 10,
        color: GlobalVariables.selectedNavBarColor,
      ),
    );
  }
}
