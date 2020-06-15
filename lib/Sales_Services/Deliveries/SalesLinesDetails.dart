import 'package:flutter/material.dart';
class SalesLinesDetails extends StatefulWidget {
  var salesLineData;

  SalesLinesDetails(this.salesLineData);

  @override
  _SalesLinesDetailsState createState() => _SalesLinesDetailsState(salesLineData);
}

class _SalesLinesDetailsState extends State<SalesLinesDetails> {
  var salesLineData;

  _SalesLinesDetailsState(this.salesLineData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sales Lines Details"),
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
                    trailing: Text(salesLineData['itemIdField']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Name"),
                    subtitle: Text(salesLineData['nameField']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Size"),
                    trailing: Text(salesLineData['sizeField']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Shade"),
                    trailing: Text(salesLineData['shadeField']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Grade"),
                    trailing: Text(salesLineData['gradeField']),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text(
              "Quantity Info",
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
                    title: Text("Boxes #"),
                    trailing: Text(salesLineData['salesQtyBoxField'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Pallet #"),
                    trailing: Text(salesLineData['salesQtyPalletField']!=null?salesLineData['salesQtyPalletField'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity in SQM"),
                    trailing: Text(salesLineData['salesQtySQMField'].toString()),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
