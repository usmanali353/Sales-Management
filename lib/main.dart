
import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:acmc_customer/LoginScreen/Login.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/TrackPalletPage.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/trackDeliveryList.dart';
import 'package:acmc_customer/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    runApp( myApp()
    );
  });

}
class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  static final navigatorKey = GlobalKey<NavigatorState>();
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
  MaterialColor myColor;
  @override
  void initState() {
     myColor = MaterialColor(0xFF004c4c, color);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "ACMC Customer",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: myColor,
      ),
      home: LoginScreen(),
    );
  }
}
