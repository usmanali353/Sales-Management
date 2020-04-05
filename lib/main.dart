import 'package:flutter/material.dart';

import 'HomePage.dart';

void main(){
  runApp(MaterialApp(
    title: "Sales Management",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark
    ),
    home: HomePage(),
  ));
}