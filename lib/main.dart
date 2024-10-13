import 'package:elevate_online_exam_app/di/di.dart';
import 'package:elevate_online_exam_app/presentaion/styles.dart';
import 'package:elevate_online_exam_app/presentaion/views/forget_password_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const OnlineExamApp());
  configureDependencies();
}

class OnlineExamApp extends StatelessWidget {
  const OnlineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: Styles().getInputDecorationTheme(),
      ),
      home: ForgetPasswordScreen(),
    );
  }
}
