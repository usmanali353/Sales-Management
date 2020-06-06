import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesmanagement/LoginScreen/Login.dart';
import 'package:salesmanagement/NewDashboard.dart';
import 'package:salesmanagement/PrePicking/PrePickingList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/Theme.dart';
import 'Model/ThemeNotifier.dart';
import 'PrePicking/AddProducts.dart';
import 'Sales_Services/Deliveries/detail_page.dart';
import 'new_dashboard.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var lightModeOn = prefs.getBool('LightMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(lightModeOn ? lightTheme : darkTheme),
        child: myApp(),
      )
    );
  });
}
class myApp extends StatefulWidget {

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return  MaterialApp(
      title: "Sales Management",
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: LoginScreen(),
    );
  }
}
