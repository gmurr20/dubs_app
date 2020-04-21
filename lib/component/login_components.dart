import 'package:flutter/material.dart';

InputDecoration createTextBoxDecoration(String label) {
  return InputDecoration(
      labelText: label,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(),
      ));
}
