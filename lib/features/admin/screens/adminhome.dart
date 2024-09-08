import 'package:smartfit/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/globals_variable.dart';

class Adminhome extends StatelessWidget {
  const Adminhome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                catw("assets/images/shoes.png", "Shoes", context),
                catw("assets/images/pents.png", "Pents", context),
              ],
            ),
            Row(
              children: [
                catw("assets/images/shirt.png", "Shirt", context),
                catw("assets/images/under.png", "Glasses", context),
              ],
            ),
            Row(
              children: [
                catw("assets/images/tie.png", "Tie", context),
                const Expanded(child: SizedBox.shrink())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget catw(String img, String title, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostsScreen(
                        title: title,
                      )));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GlobalVariables.selectedNavBarColor.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ]),
          child: Column(
            children: [
              Image.asset(
                img,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
