// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartfit/constants/error_handling.dart';
import 'package:smartfit/constants/globals_variable.dart';
import 'package:smartfit/constants/utils.dart';
import 'package:smartfit/features/admin/screens/allusers.dart';
import 'package:smartfit/features/store/storehome.dart';
import 'package:smartfit/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/bottom_bar.dart';
import '../../../main.dart';
import '../../../providers/user_provider.dart';
import '../../account/services/account_services.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String number,
    required String type,
    required String status,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: type,
        token: '',
        cart: [],
        number: number,
        status: status,
      );

      http.Response res = await http.post(
        Uri.parse('${uri}api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          if ((jsonDecode(res.body)['type'] == 'Store' &&
                  jsonDecode(res.body)['status'] == 'true') ||
              jsonDecode(res.body)['type'] == 'User') {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString('u', jsonDecode(res.body)['type']);
            await prefs.setString('id', jsonDecode(res.body)['_id']);
            await prefs.setString('name', jsonDecode(res.body)['name']);
            await prefs.setString('number', jsonDecode(res.body)['number']);
            await prefs.setString('email', jsonDecode(res.body)['email']);
            await prefs.setString('address', jsonDecode(res.body)['address']);
            if (jsonDecode(res.body)['type'] == 'Store') {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const storehome()));
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName,
                (route) => false,
              );
            }
          } else {
            showSnackBar(context, "wait for admin approval");
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List> allusers(BuildContext context) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${uri}api/allusers'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List a = jsonDecode(res.body) as List;
      return a;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  Future<void> changestatus(BuildContext context, String id) async {
    try {
      await http.post(
        Uri.parse('${uri}api/changestatus'),
        body: jsonEncode({"id": id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> delete(BuildContext context, String id) async {
    try {
      await http.post(
        Uri.parse('${uri}api/delete'),
        body: jsonEncode({"id": id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> forgetpassword(
      BuildContext context, String email, String password) async {
    http.Response res = await http.post(
      Uri.parse('${uri}api/forgetpassword'),
      body: jsonEncode({
        'email': email,
        'password': password,
        "id": prefs.getString("id"),
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () async {
        prefs.remove('u');
        prefs.remove('id');
        AccountServices().logOut(context);
        showSnackBar(context, "Password changed successfully");
      },
    );
  }

  // get user data
  // void getUserData(
  //   BuildContext context,
  // ) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? token = prefs.getString('x-auth-token');
  //
  //     if (token == null) {
  //       prefs.setString('x-auth-token', '');
  //     }
  //
  //     var tokenRes = await http.post(
  //       Uri.parse('$uri/tokenIsValid'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': token!
  //       },
  //     );
  //
  //     var response = jsonDecode(tokenRes.body);
  //
  //     if (response == true) {
  //       http.Response userRes = await http.get(
  //         Uri.parse('$uri/'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': token
  //         },
  //       );
  //
  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }
}
