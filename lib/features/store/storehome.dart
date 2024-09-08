import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:smartfit/features/store/storelist.dart';
import 'package:smartfit/features/store/storeorders.dart';
import 'package:smartfit/features/store/storeprofile.dart';


class storehome extends StatefulWidget {
  const storehome({super.key});

  @override
  State<storehome> createState() => _storehomeState();
}

class _storehomeState extends State<storehome> {
  int _page = 0;
  late CircularBottomNavigationController _navigationController;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const storelist(),
    const storeorder(),
    storeprofile(),
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
          TabItem(Icons.home_outlined, "Home", Colors.black,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          TabItem(Icons.all_inbox_outlined, "Orders", Colors.black,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          TabItem(Icons.person, "Profile", Colors.black,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
        ],
        controller: _navigationController,
        selectedPos: _page,
        selectedIconColor: Colors.white,
        normalIconColor: Colors.grey,
        barBackgroundColor: Colors.white,
        selectedCallback: (pag) => updatePage(pag ?? 0),
      ),
    );
  }
}
