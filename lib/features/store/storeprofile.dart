import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/auth/screens/forgetpassword.dart';

import '../../main.dart';
import '../account/services/account_services.dart';
import '../admin/screens/add_product_screen.dart';

class storeprofile extends StatefulWidget {
  storeprofile({super.key, this.store = true});
  bool store;

  @override
  State<storeprofile> createState() => _storeprofileState();
}

class _storeprofileState extends State<storeprofile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Profile",
              style: GoogleFonts.poppins(
                  fontSize: width(context) * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: width(context),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: GlobalVariables.selectedNavBarColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rdata("Name", prefs.getString("name")!),
                  rdata("Number", prefs.getString("number")!),
                  rdata("Email", prefs.getString("email")!),
                  // rdata("Address", prefs.getString("address")!),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            widget.store
                ? btn("Add a Product", Icons.add, navigateToAddProduct)
                : const SizedBox.shrink(),
            const SizedBox(
              height: 20,
            ),
            btn("change password", Icons.password, changepassword),
            const SizedBox(
              height: 20,
            ),
            btn("Logout", Icons.logout, (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure to LOGOUT?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        onPressed: logout,
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget btn(String title, IconData icon, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width(context),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(
              width: 20,
            ),
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: width(context) * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget rdata(String title, String data) {
    return Row(
      children: [
        Text("$title  ",
            style: GoogleFonts.poppins(
                fontSize: width(context) * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        Text(data,
            style: GoogleFonts.poppins(
                fontSize: width(context) * 0.04, color: Colors.white)),
      ],
    );
  }


  Future<void> changepassword() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => const forgetpassword()));
  }

  Future<void> navigateToAddProduct() async {
    await Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void logout() {
    prefs.remove('u');
    prefs.remove('id');
    AccountServices().logOut(context);
  }
}
