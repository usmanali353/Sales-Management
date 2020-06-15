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
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text(
                "Item Info",
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
                    title: Text("Item Id"),
                    trailing: Text(InvoiceData['ItemNumber']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Name"),
                    subtitle: Text(InvoiceData['ItemDescription']),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text(
              "Order Info",
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
                    title: Text("Order Id"),
                    trailing: Text(InvoiceData['SalesOrderId']),
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
                    title: Text("Invoice Id"),
                    trailing: Text(InvoiceData['InvoiceId']),
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
                  Divider()
                ],
              ),
            ),
          ),
//          ListTile(
//            title: Text("Order Id"),
//            subtitle: Text(InvoiceData['SalesOrderId']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Invoice Id"),
//            subtitle: Text(InvoiceData['InvoiceId']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Quantity"),
//            subtitle: Text(InvoiceData['QtyinSQM'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Pallets #"),
//            subtitle: Text(InvoiceData['NumOfPallets'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Boxes #"),
//            subtitle: Text(InvoiceData['NumOfBoxes'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Unit Price"),
//            subtitle: Text(InvoiceData['SalesUnitPrice'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Amount Without Tax"),
//            subtitle: Text(InvoiceData['LineAmount'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Sales Tax"),
//            subtitle: Text(InvoiceData['TaxAmount'].toString()),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Total Amount"),
//            subtitle: Text(InvoiceData['TotalAmount'].toString()),
//          ),
//          Divider()
        ],
      ),
    );
  }

}