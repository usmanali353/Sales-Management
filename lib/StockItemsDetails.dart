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
        itemData['Grade']!=null ? ListTile(
            title: Text("Grade"),
            trailing: Text(itemData['Grade']!=null?itemData['Grade']:''),
          ):
        ListTile(
            title: Text("Total Quantity Produced"),
           trailing: Text(itemData['QtyinSQM']!=null?itemData['QtyinSQM'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Remaining Quantity"),
            trailing: Text(itemData['OnHandQty']!=null?itemData['OnHandQty'].toString():itemData['QtyAvailablePhysical'].toString()),
          ),
          Divider(),
          itemData['ProductionId']!=null?
              ListTile(
                title: Text("Production Id"),
                trailing: Text(itemData['ProductionId']!=null?itemData['ProductionId'].toString():''),
              ):Container(),
        ],
      ),
    );
  }

}