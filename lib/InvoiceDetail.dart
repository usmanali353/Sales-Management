import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Invoice Detail"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Invoice Id"),
                trailing: Text(InvoiceData['InvoiceId']),
              ),
              Divider(),
              ListTile(
                title: Text("Invoice Date"),
                trailing: Text(InvoiceData['InvoiceDate']),
              ),
              Divider(),
              ListTile(
                title: Text("Order Id"),
                trailing: Text(InvoiceData['SalesOrderId']),
              ),
              Divider(),
              ListTile(
                title: Text("Delivery Name"),
                trailing: Text(InvoiceData['DeliveryName']),
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
              Divider(),

            ],
          )
        ],
      ),
    );
  }

}