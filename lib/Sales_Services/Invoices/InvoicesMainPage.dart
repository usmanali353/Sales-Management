import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Sales_Services/Invoices/InVoicesList.dart';
import 'package:salesmanagement/Sales_Services/Invoices/InvoiceDetail.dart';
class InvoiceMainPage extends StatefulWidget {
  var customerId;

  InvoiceMainPage(this.customerId);

  @override
  _InvoiceMainPageState createState() => _InvoiceMainPageState(customerId);
}

class _InvoiceMainPageState extends State<InvoiceMainPage> {
  var customerId;
  DateTime selectedDate=DateTime.now();
   TextEditingController invoiceNumber;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _InvoiceMainPageState(this.customerId);
 @override
  void initState() {
    invoiceNumber=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
        child: Scaffold(
          appBar: AppBar(title: Text("Finance"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (choice){
                  if(choice=='Search By Invoice Number'){
                    showInvoiceNumberAlertDialog(context);
                  }else if(choice=='Search By Date') {
                    showDateAlertDialog(context);
                  }
                },
                itemBuilder: (BuildContext context){
                  return ['Search By Invoice Number','Search By Date'].map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },

              )
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
  showInvoiceNumberAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {
        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);
          Network_Operations.GetInvoice(invoiceNumber.text).then((response) {
            if (response != null) {
              var detail = jsonDecode(response);
              if (detail['DueDate'] != "/Date(-2208956400000+0300)/") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => InvoiceDetails(detail)));
              }else{
                Flushbar(
                  message:  "No Invoice Found against this number",
                  backgroundColor: Colors.red,
                  duration:  Duration(seconds: 5),
                )..show(context);
              }
            }
          });
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Invoice Number"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              attribute: 'Invoice Number',
              controller: invoiceNumber,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Invoice Number",
              ),
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showDateAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {

        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Search by Date"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderDateTimePicker(
              attribute: 'Invoice Date',
              format: DateFormat("yyyy-MM-dd"),
              inputType: InputType.date,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Invoice Date",
              ),
              onChanged: (value){
                this.selectedDate=value;
              },
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
