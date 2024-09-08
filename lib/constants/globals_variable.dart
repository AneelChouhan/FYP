import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:3000/';
//String uri = 'https://shrub-tremendous-ghoul.glitch.me//';
double width(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context){
  return MediaQuery.of(context).size.height;
}

class GlobalVariables {

  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xFFEFBAA9),
      Color(0xFFEEE2DE),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFFEA906C);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static const selectedNavBarColor = Color(0xFFB31312);
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Shirt',
      'image': 'assets/images/shirt.png',
    },
    {
      'title': 'Pents',
      'image': 'assets/images/pents.png',
    },
    {
      'title': 'Shoes',
      'image': 'assets/images/shoes.png',
    },
    {
      'title': 'Glasses',
      'image': 'assets/images/under.png',
    },
    {
      'title': 'Tie',
      'image': 'assets/images/tie.png',
    },
  ];

  static RegExp getRegExpint() {
    return RegExp('[0-9]');
  }

  static RegExp getRegExpstring() {
    return RegExp('[a-zA-Z ]');
  }

}
