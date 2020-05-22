import 'package:flutter/material.dart';
import 'package:salesmanagement/PrePicking/PrePickingList.dart';
import 'LoginScreen/ui/login_page.dart';
import 'PrePicking/AddProducts.dart';


void main(){
  runApp(MaterialApp(
    title: "Sales Management",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.light
    ),
    home: LoginPage(),
  ));
}