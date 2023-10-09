import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'error_snackbar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      errorSnackBar(context: context, text: jsonDecode(response.body)['msg']);
      break;
    case 404:
      errorSnackBar(context: context, text: jsonDecode(response.body)['msg']);
      break;
    case 500:
      errorSnackBar(context: context, text: jsonDecode(response.body)['error']);
      break;
    default:
      errorSnackBar(context: context, text: "Invalid");
  }
}
