import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';
import 'package:smartfit/main.dart';

import '../../common/widgets/loader.dart';
import '../../constants/globals_variable.dart';
import '../../models/order.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import '../admin/models/sales.dart';
import '../admin/services/admin_services.dart';
import '../admin/widgets/category_products_chart.dart';
import '../order_details/screens/order_details.dart';

class storeorder extends StatefulWidget {
  const storeorder({super.key});

  @override
  State<storeorder> createState() => _storeorderState();
}

class _storeorderState extends State<storeorder> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  int? to;
  List<Sales> earnings = [];

  @override
  void initState() {
    super.initState();
    getEarnings();
    fetchOrders();
    setState(() {});
  }

  getEarnings() async {
    var earningData =
        await adminServices.getEarnings(context, prefs.getString("id")!);
    totalSales = earningData['totalEarnings'];
    to = earningData['to'];
    earnings = earningData['sales'];
    setState(() {});
  }

  void fetchOrders() async {
    orders =
        await adminServices.fetchAllOrders(context, prefs.getString("id")!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Your",
                  style: GoogleFonts.redHatMono(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Analytics",
                  style: GoogleFonts.redHatMono(fontSize: 30),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                topdata("assets/orders.png", 'Total Orders',
                    to.toString()),
                const SizedBox(
                  width: 10,
                ),
                topdata("assets/sales.png", 'Total Sales', '\$$totalSales'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: 250,
              child: CategoryProductsChart(seriesList: [
                charts.Series(
                  colorFn: (_, __) => charts.ColorUtil.fromDartColor(
                    const Color.fromARGB(255, 210, 210, 210),
                  ),
                  id: 'Sales',
                  data: earnings,
                  domainFn: (Sales sales, _) => sales.label,
                  measureFn: (Sales sales, _) => sales.earnings,
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  "Your",
                  style: GoogleFonts.redHatMono(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Orders",
                  style: GoogleFonts.redHatMono(fontSize: 30),
                ),
              ],
            ),
          ),
          orders == null
              ? const Loader()
              : Expanded(
                  child: OnyxsioGridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: orders!.length,
                  physics: const BouncingScrollPhysics(),
                  staggeredTileBuilder: (index) =>
                      const OnyxsioStaggeredTile.fit(2),
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final orderData = orders![index];
                    return OnyxsioGridTile(
                      index: index,
                      heightList: const [],
                      child: InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, OrderDetailScreen.routeName,
                              arguments: {"order":orders![index],"type":"store"});
                          fetchOrders();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  orderData.products[0].images[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                orderData.products[0].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.b612Mono(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
        ],
      )),
    );
  }

  Widget topdata(
    img,
    title,
    des,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  img,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: GoogleFonts.b612Mono(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: GlobalVariables.selectedNavBarColor),
                ),
              ],
            ),
            Text(
              des,
              style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
