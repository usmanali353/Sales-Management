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
                subtitle: Text(InvoiceData['SalesOrderId']),
              ),
              Divider(),
              ListTile(
                title: Text("Invoice Id"),
                subtitle: Text(InvoiceData['InvoiceId']),
              ),
              Divider(),
              ListTile(
                title: Text("Quantity"),
                subtitle: Text(InvoiceData['QtyinSQM'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Pallets #"),
                subtitle: Text(InvoiceData['NumOfPallets'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Boxes #"),
                subtitle: Text(InvoiceData['NumOfBoxes'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Unit Price"),
                subtitle: Text(InvoiceData['SalesUnitPrice'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Amount Without Tax"),
                subtitle: Text(InvoiceData['LineAmount'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Sales Tax"),
                subtitle: Text(InvoiceData['TaxAmount'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Total Amount"),
                subtitle: Text(InvoiceData['TotalAmount'].toString()),
              ),
              Divider(),



            ],
          )
        ],
      ),
    );
  }

}