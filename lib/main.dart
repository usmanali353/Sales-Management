import 'package:flutter/material.dart';
import 'package:salesmanagement/Dashboard.dart';
import 'package:salesmanagement/LoginScreen/ui/login_page.dart';
import 'package:salesmanagement/NewDashboard.dart';
import 'package:salesmanagement/TruckLogo.dart';

import 'HomePage.dart';

void main(){
  runApp(MaterialApp(
    title: "Sales Management",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark
    ),
    home: TruckLogo(),
  ));
}