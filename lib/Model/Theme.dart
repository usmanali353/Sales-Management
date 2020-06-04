import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
);
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
final lightTheme = ThemeData(
  primarySwatch: myColor,
  brightness: Brightness.light,
);