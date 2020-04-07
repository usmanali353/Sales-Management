

import 'package:flutter/material.dart';


class invoiceLineDetails extends StatefulWidget{
  var InvoiceData;

  invoiceLineDetails(this.InvoiceData);

  @override
  State<StatefulWidget> createState() {
    return _invoiceLineDetails(InvoiceData);
  }

}
class _invoiceLineDetails extends State<invoiceLineDetails>{
  var InvoiceData;

  _invoiceLineDetails(this.InvoiceData);
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Line Detail"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Order Id"),
                trailing: Text(InvoiceData['SalesOrderId']),
              ),
              Divider(),
              ListTile(
                title: Text("Invoice Id"),
                trailing: Text(InvoiceData['InvoiceId']),
              ),
              Divider(),
              ListTile(
                title: Text("Quantity"),
                trailing: Text(InvoiceData['QtyinSQM'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Pallets #"),
                trailing: Text(InvoiceData['NumOfPallets'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Boxes #"),
                trailing: Text(InvoiceData['NumOfBoxes'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Unit Price"),
                trailing: Text(InvoiceData['SalesUnitPrice'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Amount Without Tax"),
                trailing: Text(InvoiceData['LineAmount'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Sales Tax"),
                trailing: Text(InvoiceData['TaxAmount'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Total Amount"),
                trailing: Text(InvoiceData['TotalAmount'].toString()),
              ),
              Divider(),



            ],
          )
        ],
      ),
    );
  }

}