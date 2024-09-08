import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:smartfit/common/widgets/custom_button.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/features/admin/services/admin_services.dart';
import 'package:smartfit/features/search/screens/search_screen.dart';
import 'package:smartfit/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  final String type;
  const OrderDetailScreen({super.key, required this.order, required this.type});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;
  final AdminServices adminServices = AdminServices();

  final TextEditingController _searchController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        // Handle speech recognition status changes if needed
      },
      onError: (error) {
        // Handle speech recognition errors if needed
      },
    );
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _searchText = result.recognizedWords;
            _searchController.text = _searchText;
          });
        },
      );
    }
  }

  Future<void> _stopListening() async {
    setState(() {
      _isListening = false;
    });
    await _speech.stop();
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    if (widget.order.status >= 0 && widget.order.status < 4) {
      currentStep = widget.order.status;
    }
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status + 1,
      order: widget.order,
      onSuccess: () {
        setState(() {
          currentStep += 1;
        });
      },
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.selectedNavBarColor,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: _searchController,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {
                            if (_isListening) {
                              _stopListening();
                            } else {
                              _startListening();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Icon(
                              _isListening ? Icons.mic_off : Icons.mic,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search smartFit.io',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View order details',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Date:          ${widget.order.date}',
                      style: GoogleFonts.nunito(),
                    ),
                    Text(
                      'Order ID:          ${widget.order.id}',
                      style: GoogleFonts.nunito(),
                    ),
                    Text(
                      'Order Total:      ${widget.order.totalPrice}',
                      style: GoogleFonts.nunito(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Purchase Details',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.order.products[i].images[0],
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: GoogleFonts.b612Mono(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Qty: ${widget.order.quantity[i]}',
                                    style: GoogleFonts.b612Mono(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tracking',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              (widget.type == "admin" || widget.type == "store") &&
                      widget.order.status == 0
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        text: 'Deliver Order',
                        onTap: () => changeOrderStatus(widget.order.status),
                      ),
                    )
                  : widget.type == "user" && widget.order.status == 1
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: CustomButton(
                            text: 'Complete Order',
                            onTap: () => changeOrderStatus(widget.order.status),
                          ),
                        )
                      : const SizedBox.shrink(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                      title: Text(
                        'Pending',
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text(
                        'Your order is yet to be delivered',
                        style: GoogleFonts.poppins(),
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text(
                        'Delivered',
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text(
                        'Your order has been delivering',
                        style: GoogleFonts.poppins(),
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Text(
                        'Completed',
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text(
                        'Your order has been delivered',
                        style: GoogleFonts.poppins(),
                      ),
                      isActive: currentStep >= 2,
                      state: currentStep >= 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
