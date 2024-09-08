import 'dart:io';

import 'package:smartfit/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/custom_textfield.dart';
import '../../../common/firebsaeuploadhelper.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../constants/globals_variable.dart';
import '../../../constants/utils.dart';
import '../../admin/services/admin_services.dart';

class updateproductscreen extends StatefulWidget {
  updateproductscreen({super.key, required this.data});
  Product data;

  @override
  State<updateproductscreen> createState() => _updateproductscreenState();
}

class _updateproductscreenState extends State<updateproductscreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  List<File> images = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  Future<void> sellProduct() async {
    if (productNameController.text.isNotEmpty || descriptionController.text.isNotEmpty
        || priceController.text.isNotEmpty || quantityController.text.isNotEmpty) {
      List ff = widget.data.images;
      if(images.isNotEmpty){
        for (int i = 0; i < images.length; i++) {
          String url = await FirebaseHelper.uploadFile(images[i]);
          ff.add(url);
        }
      }
      adminServices.updateproduct(
        context: context,
        productId: widget.data.id!,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        images: ff
      );
      setState(() {});
    }

  }

  @override
  void initState() {
    productNameController.text = widget.data.name;
    descriptionController.text = widget.data.description;
    priceController.text = widget.data.price.toString();
    quantityController.text = widget.data.quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
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
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Text(
            'Update Product',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: widget.data.images.map((e) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) => Image.file(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 200,
                  ),
                )
                    : GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Select Product Image',
                            style: GoogleFonts.poppins(
                              fontSize: width(context)*0.05,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Update',
                  onTap: sellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
