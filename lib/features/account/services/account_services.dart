// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:smartfit/constants/utils.dart';
import 'package:smartfit/features/auth/screens/auth_screen.dart';
import 'package:smartfit/main.dart';
import 'package:smartfit/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartfit/constants/error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/globals_variable.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.post(Uri.parse('${uri}api/orders/me'),
              headers: {'Content-Type': 'application/json; charset=UTF-8',},
            body: jsonEncode({'users':prefs.getString('id')})
          );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
