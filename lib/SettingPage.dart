import 'package:flutter/material.dart';
import 'package:salesmanagement/webBrowser.dart';
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Visit our Website"),
            leading: Icon(Icons.web),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WebBrowser('https://www.arabian-ceramics.com/en-us/')));
            },
          ),
          Divider(),
          ListTile(
            title: Text("About US"),
            leading: Icon(Icons.web),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WebBrowser('https://www.arabian-ceramics.com/en-us/about-us')));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
