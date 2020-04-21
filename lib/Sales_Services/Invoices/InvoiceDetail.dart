
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
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Invoice Id"),
                subtitle: Text(InvoiceData['InvoiceId']),
              ),
              Divider(),
              ListTile(
                title: Text("Invoice Date"),
                subtitle: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(InvoiceData['InvoiceDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
              ),
              Divider(),
              ListTile(
                title: Text("Order Id"),
                subtitle: Text(InvoiceData['SalesOrderId']),
              ),
              Divider(),
              ListTile(
                title: Text("Delivery Name"),
                subtitle: Text(InvoiceData['DeliveryName']),
              ),
              Divider(),
              ListTile(
                title: Text("Sales Tax"),
                subtitle: Text(InvoiceData['SalesTaxAmount'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Total Amount"),
                subtitle: Text(InvoiceData['InvoiceAmount'].toString()),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }

}