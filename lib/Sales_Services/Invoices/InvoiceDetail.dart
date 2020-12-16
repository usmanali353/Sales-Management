
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Network_Operations.dart';
import 'InvoiceLines.dart';
import 'package:acmc_customer/Model/Invoices.dart';


class InvoiceDetails extends StatefulWidget{
  Invoices InvoiceData;

  InvoiceDetails(this.InvoiceData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InvoiceDetails();
  }

}
class _InvoiceDetails extends State<InvoiceDetails>{
 @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Detail"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Network_Operations.GetInvoice(context,widget.InvoiceData.invoiceId).then((response){
                if(response!=null&&response!=''&&response!='[]'){
                  setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoiceLines(jsonDecode(response))));
                  });
                }
              });
            },
            child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("View Invoice Lines",style: TextStyle(color: Colors.white),),
            )),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text(
                "Order Info",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Order Id"),
                    trailing: Text(widget.InvoiceData.salesOrderId),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Delivery Name"),
                    subtitle: Text(widget.InvoiceData.deliveryName),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text(
              "Invoice Info",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Invoice Date"),
                    trailing: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.InvoiceData.invoiceDate.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Invoice Id"),
                    trailing: Text(widget.InvoiceData.invoiceId),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount without Tax"),
                    trailing: Text(widget.InvoiceData.salesAmount!=null?widget.InvoiceData.salesAmount.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Sales Tax"),
                    trailing: Text(widget.InvoiceData.salesTaxAmount.toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Total Amount"),
                    trailing: Text(widget.InvoiceData.invoiceAmount.toString()),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
//          ListTile(
//            title: Text("Invoice Id"),
//            subtitle: Text(InvoiceData['InvoiceId']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Invoice Date"),
//            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(InvoiceData['InvoiceDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Order Id"),
//            subtitle: Text(InvoiceData['SalesOrderId']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Delivery Name"),
//            subtitle: Text(InvoiceData['DeliveryName']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Sales Tax"),
//            subtitle: Text(InvoiceData['SalesTaxAmount'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Total Amount"),
//            subtitle: Text(InvoiceData['InvoiceAmount'].toString()),
//          ),
//          Divider()
        ],
      ),
    );
  }

}