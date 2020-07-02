import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesmanagement/Model/Theme.dart';
import 'package:salesmanagement/webBrowser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/ThemeNotifier.dart';
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(title: Text("Settings"),),
      body: WillPopScope(
        onWillPop:() async{
          Navigator.pop(context,'Refresh');
          return false;
        },
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Theme'),
              contentPadding: const EdgeInsets.only(left: 16.0),
              trailing: Transform.scale(
                scale: 0.4,
                child: DayNightSwitch(
                  value: _darkTheme,
                  onChanged: (val) {
                    setState(() {
                      _darkTheme = val;
                    });
                    onThemeChanged(val, themeNotifier);
                  },
                ),
              ),
            ),
            ListTile(
              title: Text("Visit our Website"),
              trailing: Icon(Icons.web),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebBrowser('https://www.arabian-ceramics.com/en-us/')));
              },
            ),
            Divider(),
            ListTile(
              title: Text("About US"),
              trailing: Icon(Icons.contact_mail),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WebBrowser('https://www.arabian-ceramics.com/en-us/about-us')));
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('DarkMode', value);
  }
}

