import 'package:flutter/material.dart';
import 'package:salesmanagement/NewDashboard.dart';
import 'package:salesmanagement/PrePicking/PrePickingList.dart';
import 'LoginScreen/ui/login_page.dart';
import 'PrePicking/AddProducts.dart';
import 'Sales_Services/Deliveries/detail_page.dart';
import 'new_dashboard.dart';


void main(){
  Map<int, Color> color =
  {
    50:Color.fromRGBO(0,96,94,  .1),
    100:Color.fromRGBO(0,96,94, .2),
    200:Color.fromRGBO(0,96,94, .3),
    300:Color.fromRGBO(0,96,94, .4),
    400:Color.fromRGBO(0,96,94, .5),
    500:Color.fromRGBO(0,96,94, .6),
    600:Color.fromRGBO(0,96,94, .7),
    700:Color.fromRGBO(0,96,94, .8),
    800:Color.fromRGBO(0,96,94, .9),
    900:Color.fromRGBO(0,96,94,  1),
  };
  MaterialColor myColor = MaterialColor(0xFF004c4c, color);
  runApp(MaterialApp(
    title: "Sales Management",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: myColor,
      brightness: Brightness.light
    ),
    home: LoginPage(),
  ));
}