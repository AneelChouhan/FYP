import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';

import '../../common/widgets/loader.dart';
import '../../constants/globals_variable.dart';
import '../../main.dart';
import '../../models/product.dart';
import '../admin/services/admin_services.dart';
import '../product_details/screens/updateproductscreen.dart';

class storelist extends StatefulWidget {
  const storelist({super.key});

  @override
  State<storelist> createState() => _storelistState();
}

class _storelistState extends State<storelist> {
  TextEditingController s = TextEditingController();
  List<String> cats = ["All", "Shoes", "Pents", "Shirt", "Tie", "Glasses"];
  String cat = 'All';

  final AdminServices adminServices = AdminServices();
  List products = [];

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15, top: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your",
                            style: GoogleFonts.redHatMono(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Store",
                            style: GoogleFonts.redHatMono(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width(context) * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: TextFormField(
                        controller: s,
                        onChanged: (s) {
                          fetchAllProducts();
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.all(10),
              width: width(context),
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cats.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        cat = cats[index];
                        fetchAllProducts();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              cat == cats[index] ? Colors.black : Colors.white),
                      child: Center(
                        child: Text(
                          cats[index],
                          style: GoogleFonts.montserrat(
                              color: cat == cats[index]
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: products.isEmpty
                  ? const Loader()
                  : OnyxsioGridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: products.length,
                      physics: const BouncingScrollPhysics(),
                      staggeredTileBuilder: (index) =>
                          const OnyxsioStaggeredTile.fit(2),
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final productData = products[index];
                        return OnyxsioGridTile(
                          index: index,
                          heightList: const [],
                          child: listdata(productData, index),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    List f = await adminServices.fetchAllProducts(context);
    products.clear();
    for (var element in f) {
      if (element.addedby == prefs.getString('id')) {
        filter(element);
      }
    }
    setState(() {});
  }

  void filter(element) {
    if (cat == 'All') {
      return searchbar(element);
    } else if (cat == element.category) {
      return searchbar(element);
    }
  }

  void searchbar(element) {
    if (s.text.isEmpty) {
      products.add(element);
    } else if (element.name.toLowerCase().contains(s.text.toLowerCase())) {
      products.add(element);
    }
  }

  Widget listdata(productData, index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => updateproductscreen(data: productData)));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                productData.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rs ${productData.price}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style:
                              GoogleFonts.b612Mono(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.b612Mono(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => deleteProduct(productData, index),
                    icon: const Icon(
                      Icons.delete_outline,
                      color: GlobalVariables.selectedNavBarColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
