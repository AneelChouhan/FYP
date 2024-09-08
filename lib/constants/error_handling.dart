import 'dart:convert';
import 'dart:developer';

import 'package:smartfit/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      // log('200:onsucess');
      // log(jsonDecode(response.body).toString());
      onSuccess();
      break;

    case 400:
      // log('400');
      // log(jsonDecode(response.body).toString());
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;

    case 500:
      // log('500');
      // log(jsonDecode(response.body).toString());
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;

    default:
      // log('default');
      // log(jsonDecode(response.body).toString());
      showSnackBar(context, response.body);
    
}
}
