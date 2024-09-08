import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/account/widgets/single_product.dart';
import 'package:smartfit/features/admin/services/admin_services.dart';
import 'package:smartfit/features/product_details/screens/updateproductscreen.dart';
import 'package:smartfit/models/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/loader.dart';
import '../../../main.dart';
import '../../account/services/account_services.dart';
import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  PostsScreen({super.key,required this.title});
  String title ;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List products = [];
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    List f = await adminServices.fetchAllProducts(context);
    for (var element in f) {
      final productData = element;
      if(productData.addedby == "admin") {
        if(productData.category == widget.title) {
          products.add(element);
        }
      }
    }
    setState(() {});
  }

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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      color: GlobalVariables.selectedNavBarColor),
                ),
                title: Row(
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
                    )
                  ],
                ),
              ),
            ),
            body: products.isEmpty
                ? const Loader()
                : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            updateproductscreen(data: productData)));
                  },
                  child: Container(
                    color: GlobalVariables.secondaryColor.withOpacity(0.05),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: SingleProduct(
                            image: productData.images[0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  productData.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    deleteProduct(productData, index),
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
              },
            ),
          );
  }
}
