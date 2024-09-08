import 'package:smartfit/common/widgets/loader.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/admin/models/sales.dart';
import 'package:smartfit/features/admin/services/admin_services.dart';
import 'package:smartfit/features/admin/widgets/category_products_chart.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final TextEditingController costController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  int? to;
  List<Sales>? earnings;
  double? profit;
  double? loss;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context, 'admin');
    print(earningData);
    totalSales = earningData['totalEarnings'];
    to = earningData['to'];
    earnings = earningData['sales'];
    setState(() {});
  }

  void calculateProfitOrLoss() {
    double cost = double.tryParse(costController.text) ?? 0.0;
    double sellingPrice = double.tryParse(sellingPriceController.text) ?? 0.0;

    double profitOrLoss = sellingPrice - cost;

    if (profitOrLoss >= 0) {
      profit = profitOrLoss;
      loss = 0;
    } else {
      profit = 0;
      loss = -profitOrLoss;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Orders',
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.selectedNavBarColor),
                      ),
                      Text(
                        to.toString(),
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Analytics Tool',
                        style: GoogleFonts.openSans(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.selectedNavBarColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$$totalSales',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: CategoryProductsChart(seriesList: [
                          charts.Series(
                            id: 'Sales',
                            data: earnings!,
                            domainFn: (Sales sales, _) => sales.label,
                            measureFn: (Sales sales, _) => sales.earnings,
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  // Container for the Profit Loss Calculator section
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                  child: Column(
                    children: [
                      Text(
                        'Profit Loss \nCalculator',
                        style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.selectedNavBarColor),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: costController,
                        decoration: const InputDecoration(
                          labelText: 'Cost',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: sellingPriceController,
                        decoration: const InputDecoration(
                          labelText: 'Selling Price',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: calculateProfitOrLoss,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: GlobalVariables.selectedNavBarColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Calculate',style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,color: Colors.white
                            ),)),
                      ),
                      const SizedBox(height: 10),
                      if (profit != null)
                        Text(
                          'Profit: \$${profit!.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (loss != null)
                        Text(
                          'Loss: \$${loss!.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
