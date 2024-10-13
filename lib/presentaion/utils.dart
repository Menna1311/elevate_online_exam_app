import 'package:elevate_online_exam_app/domain/common/custom_exeption.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String extractErrorMessage(Exception? exception) {
  var message = "something went wrong";
  if (exception is NoInternetError) {
    message = "please check internet connection";
  } else if (exception is DioHttpException) {
    if (exception.exception?.response?.statusCode == 401) {
      message = "please login again";
    }
    message = exception.exception?.response!.data['message'] ??
        "something went wrong";
  }
  return message;
}

void showCustomDialog(BuildContext context,
    {required String message, required String title}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
