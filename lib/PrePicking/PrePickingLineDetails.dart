import 'package:flutter/material.dart';
class PickingLinesDetails extends StatefulWidget {
  var prePickingData;

  PickingLinesDetails(this.prePickingData);

  @override
  _PickingLinesDetailsState createState() => _PickingLinesDetailsState(prePickingData);
}

class _PickingLinesDetailsState extends State<PickingLinesDetails> {
  var prePickingData;

  _PickingLinesDetailsState(this.prePickingData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details"),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Item Number"),
                    trailing: Text(prePickingData['ItemNumber']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Ordered Quantity"),
                    trailing: Text(prePickingData['SalesQuantity'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Size"),
                    trailing: Text(prePickingData['SizeItem']!=null?prePickingData['SizeItem']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Inventory Dimension"),
                    trailing: Text(prePickingData['InventoryDimension']!=null?prePickingData['InventoryDimension']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Grade"),
                    trailing: Text(prePickingData['Grade']!=null?prePickingData['Grade']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Color"),
                    trailing: Text(prePickingData['ColorItem']!=null?prePickingData['ColorItem']:''),
                  ),
                  Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
