import 'package:flutter/material.dart';
import 'app/home_screen/views/Home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "KStore",
      routes: {
        '/': (context) => HomePage(),
      },
    ),
  );
}
