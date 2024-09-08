import 'package:smartfit/common/widgets/loader.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/account/services/account_services.dart';
import 'package:smartfit/features/account/widgets/single_product.dart';
import 'package:smartfit/features/order_details/screens/order_details.dart';
import 'package:smartfit/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
// ignore: library_private_types_in_public_api
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Text(
                        'Your Order',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 15,
                      ),
                      child: Text(
                        'See all',
                        style: GoogleFonts.poppins(
                          color: GlobalVariables.selectedNavBarColor,
                        ),
                      ),
                    ),
                  ],
                ),
                //display orders
                Expanded(
                  child: ListView.builder(
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 170,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.pushNamed(
                                context, OrderDetailScreen.routeName,
                                arguments: {
                                  "order": orders![index],
                                  "type": "user"
                                });
                            fetchOrders();
                          },
                          child: Row(
                            children: [
                              SingleProduct(
                                image: orders![index]
                                    .products[0]
                                    .images[0]
                                    .toString(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      orders![index].products[0].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      orders![index]
                                          .products[0]
                                          .price
                                          .toString(),
                                      style: GoogleFonts.poppins(
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      orders![index].products[0].description,
                                      style: GoogleFonts.poppins(),
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
                ),
              ],
            ),
          );
  }
}
