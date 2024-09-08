
import 'package:smartfit/constants/globals_variable.dart';
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: GlobalVariables.secondaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            // primary: GlobalVariables.secondaryColor.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: onTap,
          child: Text(text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
