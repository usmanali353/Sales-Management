import 'package:flutter/material.dart';
import 'package:salesmanagement/Sales_Services/Invoices/InVoicesList.dart';
class InvoiceMainPage extends StatefulWidget {
  @override
  _InvoiceMainPageState createState() => _InvoiceMainPageState();
}

class _InvoiceMainPageState extends State<InvoiceMainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("Finance"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Paid",),
                Tab(text: "Un Paid",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              InvoicesList('LC0001'),
              InvoicesList('LC0001'),
            ],
          ),
        ),
    );
  }
}
