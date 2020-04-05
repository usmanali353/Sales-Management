import 'package:flutter/material.dart';

class StockItemDetail extends StatefulWidget{
  var itemData;

  StockItemDetail(this.itemData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StockItemDetail(itemData);
  }

}
class _StockItemDetail extends State<StockItemDetail>{
  var itemData;

  _StockItemDetail(this.itemData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Stock Item Detail"),),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Item Name"),
            trailing: Text(itemData['ItemDescription']!=null?itemData['ItemDescription']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Item Number"),
            trailing: Text(itemData['ItemNumber']!=null?itemData['ItemNumber']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Grade"),
            trailing: Text(itemData['Grade']!=null?itemData['Grade']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Item Quantity"),
            trailing: Text(itemData['OnHandQty']!=null?itemData['OnHandQty'].toString():''),
          ),
          Divider(),
        ],
      ),
    );
  }

}