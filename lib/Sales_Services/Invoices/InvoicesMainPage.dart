import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:acmc_customer/Sales_Services/Invoices/InVoicesList.dart';
import 'package:acmc_customer/Sales_Services/Invoices/InvoiceDetail.dart';
class InvoiceMainPage extends StatefulWidget {
  var customerId;

  InvoiceMainPage(this.customerId);

  @override
  _InvoiceMainPageState createState() => _InvoiceMainPageState(customerId);
}

class _InvoiceMainPageState extends State<InvoiceMainPage> {
  var customerId;


  _InvoiceMainPageState(this.customerId);
 @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("Finance"),
            actions: <Widget>[

            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Paid",),
                Tab(text: "Un Paid",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              InvoicesList(customerId),
              InvoicesList(customerId),
            ],
          ),
        ),
    );
  }

}
