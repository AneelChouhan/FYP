// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:smartfit/constants/globals_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VIRTUAL TRY ON WITH AR',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VirtualTryOnPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: GlobalVariables.selectedNavBarColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.accessibility_new_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        ' Try With Augmented Reality',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PRODUCT RECOMMENDATION',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // decoration: TextDecoration.underline,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
              const SizedBox(height: 20),
              CarouselSlider(
                items: GlobalVariables.carouselImages.map((i) {
                  return Builder(
                    builder: (BuildContext context) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        i,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// VirtualTryOnPage and launchURL methods remain the same

class VirtualTryOnPage extends StatelessWidget {
  final List<String> snapchatUrls = [
    'https://lens.snapchat.com/4394187f0b4c428c913656befdfcc633?share_id=BBCCa9fseJ4&locale=en-GB',
    'https://lens.snapchat.com/35bc001ea386442ea1b7954527950c8e?share_id=N7eWayFqB1c&locale=en-GB',
    'https://www.snapchat.com/unlock/?type=SNAPCODE&uuid=73459e2fa9f84bbf8684b38167e34525&metadata=01&web_client_id=d6b5ba6d-cff8-4d1e-8fbe-1a3f6d3696ec',
    'https://lens.snapchat.com/5da01f0241bc4273bae9362a73b35684?share_id=ruv1p4fogso&locale=en-US',
    'https://lens.snapchat.com/3a8ee8b9ad7947fbad0ac0dd05d713ae?share_id=NfhZgOJOKmg&locale=en-US',
    'https://lens.snapchat.com/386e2c307fa34f76ae1c7303277dcc50?share_id=voA6UnvcQ2k&locale=en-US',
    'https://lens.snapchat.com/bd94a33a1d934a7fbdc28a5aad4db498?share_id=MfKsP4d_bJc&locale=en-US',
    'https://lens.snapchat.com/505cc05c93f54f04b3735973dece2b85?share_id=6ozRpYlivJc&locale=en-US',
    'https://lens.snapchat.com/66e55471e825463989768f41a80aaa6e?share_id=AllkjQgGPLQ&locale=en-US',
    'https://lens.snapchat.com/18c3b6a2eff14ad8beca403a27cad54a?share_id=-Khcx_B-nWc&locale=en-US',
    'https://lens.snapchat.com/9cac09d1dbef4005bde7ab2246e67945?share_id=nzcQtq_GnCA&locale=en-US',
    'https://lens.snapchat.com/3e4fba9c460547939135699af99f5214?share_id=Rth2oD4MkUI&locale=en-US',
    'https://lens.snapchat.com/b3ab4bcbcdca4171903be0a2d7a90fc7?share_id=ysjUQV1L090&locale=en-US',
    'https://lens.snapchat.com/573f60e0472741c9aa449522b1025fee',
  ];

  VirtualTryOnPage({super.key});

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){Navigator.pop(context);},
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        backgroundColor: GlobalVariables.selectedNavBarColor,
        title: Text('Virtual Try-On',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,
              color: Colors.white),),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection('Shirt', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[2]),
                    child: Text(
                      'White Polo',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[3]),
                    child: Text(
                      'Blue Shirt',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Jeans', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[6]),
                    child: Text(
                      'Damage Jeans',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[13]),
                    child: Text(
                      'Cotton Jeans',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Women Maxi', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[11]),
                    child: Text(
                      'Black Maxi',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[12]),
                    child: Text(
                      'Jayli Maxi',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Shoes', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[0]),
                    child: Text(
                      'Nike Shoe',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[1]),
                    child: Text(
                      'Hush Puppies',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Watches', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[4]),
                    child: Text(
                      'Apple I - Watch',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[5]),
                    child: Text(
                      'Mens Watch',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Caps', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[7]),
                    child: Text(
                      'Fortnite Cap',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[8]),
                    child: Text(
                      'Gucci Cap',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
                _buildSection('Glasses', [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[9]),
                    child: Text(
                      'Specs Glasses',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          GlobalVariables.selectedNavBarColor),
                    ),
                    onPressed: () => launchURL(snapchatUrls[10]),
                    child: Text(
                      'Oval Glasses',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> buttons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Aligns items at the center
          children: [
            const Icon(Icons.shopping_bag, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              color: GlobalVariables.secondaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buttons,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
