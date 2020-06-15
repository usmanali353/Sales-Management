
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Network_Operations.dart';
import 'InvoiceLines.dart';


class InvoiceDetails extends StatefulWidget{
  var InvoiceData;

  InvoiceDetails(this.InvoiceData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InvoiceDetails(InvoiceData);
  }

}
class _InvoiceDetails extends State<InvoiceDetails>{
  var InvoiceData;

  _InvoiceDetails(this.InvoiceData);
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
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();
              Network_Operations.GetInvoice(InvoiceData['InvoiceId']).then((response){
                pd.dismiss();
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
                    trailing: Text(InvoiceData['SalesOrderId']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Delivery Name"),
                    subtitle: Text(InvoiceData['DeliveryName']),
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
                    trailing: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(InvoiceData['InvoiceDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Invoice Id"),
                    trailing: Text(InvoiceData['InvoiceId']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Amount without Tax"),
                    trailing: Text(InvoiceData['SalesAmount']!=null?InvoiceData['SalesAmount'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Sales Tax"),
                    trailing: Text(InvoiceData['SalesTaxAmount'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Total Amount"),
                    trailing: Text(InvoiceData['InvoiceAmount'].toString()),
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