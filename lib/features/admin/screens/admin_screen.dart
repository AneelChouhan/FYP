// ignore_for_file: use_super_parameters

import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/admin/screens/allusers.dart';
import 'package:smartfit/features/admin/screens/posts_screen.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../account/services/account_services.dart';
import 'add_product_screen.dart';
import 'adminhome.dart';
import 'analytics_screen.dart';
import 'orders_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  late CircularBottomNavigationController _navigationController;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const Adminhome(),
    const AnalyticsScreen(),
    const OrdersScreen(),
    const allusers(),
  ];

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void logout() {
    prefs.remove('u');
    prefs.remove('id');
    AccountServices().logOut(context);
  }

  @override
  void initState() {
    _navigationController = CircularBottomNavigationController(0);
    super.initState();
  }

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.selectedNavBarColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      width: 120,
                      height: 45,
                      color: GlobalVariables.backgroundColor,
                    ),
                  ),
                  Text(
                    'Admin',
                    style: GoogleFonts.poppins(
                      color: GlobalVariables.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
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
                },
                child: const Icon(Icons.logout,color: Colors.white,),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar:
      CircularBottomNavigation(
        [
          TabItem(
            Icons.home_outlined,
            "Home",
            Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
            Icons.analytics_outlined,
            "Analytics",
            Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
            Icons.all_inbox_outlined,
            "Orders",
            Colors.white,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
              Icons.supervised_user_circle,
              "User",
              Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
        ],
        controller: _navigationController,
        selectedPos: _page,
        selectedIconColor: GlobalVariables.selectedNavBarColor,
        normalIconColor: Colors.white,
        selectedCallback: (pag)=>updatePage(pag??0),
        barBackgroundColor: GlobalVariables.selectedNavBarColor,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: GlobalVariables.selectedNavBarColor,
            onPressed: navigateToAddProduct,
            tooltip: 'Add a Product',
            child: const Icon(Icons.add,color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
