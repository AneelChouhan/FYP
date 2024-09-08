import 'package:smartfit/common/widgets/loader.dart';
import 'package:smartfit/features/account/widgets/single_product.dart';
import 'package:smartfit/features/admin/services/admin_services.dart';
import 'package:smartfit/features/order_details/screens/order_details.dart';
import 'package:smartfit/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context, "admin");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.9, crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(
                      context, OrderDetailScreen.routeName,
                      arguments: {"order": orders![index], "type": "admin"});
                  fetchOrders();
                },
                child: Container(
                  margin: const EdgeInsets.all(1),
                  height: 180,
                  child: Column(
                    children: [
                      SingleProduct(
                        image: orderData.products[0].images[0],
                      ),
                      Text(
                        orderData.products[0].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
