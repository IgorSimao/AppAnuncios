import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(MaterialApp(
    title: "Mercado Livre",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      useMaterial3: true,
    ),
    home: HomePage(),
  ));
}
