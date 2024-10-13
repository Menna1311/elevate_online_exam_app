import 'package:flutter/material.dart';

class Styles {
  InputDecorationTheme getInputDecorationTheme() {
    return InputDecorationTheme(
        hintStyle: TextStyle(fontWeight: FontWeight.w300),
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        border: OutlineInputBorder());
  }
}
