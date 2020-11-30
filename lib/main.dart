import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesmanagement/LoginScreen/Login.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/trackDeliveryList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/Theme.dart';
import 'Model/ThemeNotifier.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
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
      theme: ThemeData.light(),
      home: LoginScreen(),
    );
  }
}
