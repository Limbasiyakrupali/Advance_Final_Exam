import 'package:advance_final_exam/view/screens/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => HomePage(),
      'home': (context) => HomePage(),
    },
  ));
}
