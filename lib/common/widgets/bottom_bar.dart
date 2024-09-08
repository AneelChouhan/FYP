import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/account/screens/account_screen.dart';
import 'package:smartfit/features/home/screens/home_screen.dart';
import 'package:smartfit/features/store/storeprofile.dart';
import 'package:smartfit/providers/user_provider.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../../features/cart/screen/cart_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  late CircularBottomNavigationController _navigationController;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    storeprofile(store: false,)
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    _navigationController = CircularBottomNavigationController(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(
              Icons.home_outlined,
              "Home",
              Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
              Icons.add_business,
              "Order",
              Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
              Icons.shopping_cart_outlined,
              "Cart",
              Colors.white,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
          ),
          TabItem(
              Icons.person,
              "Profile",
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
    );
  }
}
