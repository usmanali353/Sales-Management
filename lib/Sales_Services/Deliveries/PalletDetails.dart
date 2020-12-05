import 'package:flutter/material.dart';
import 'package:salesmanagement/Model/DeliveryItems.dart';
class PalletDetails extends StatefulWidget {
  DeliveryItems items;

  PalletDetails(this.items);

  @override
  _PalletDetailsState createState() => _PalletDetailsState();
}

class _PalletDetailsState extends State<PalletDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pallet Details"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Item Grade"),
                    trailing: Text(widget.items.gradeField!=null?widget.items.gradeField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Size"),
                    trailing: Text(widget.items.sizeField!=null?widget.items.sizeField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Shade"),
                    trailing: Text(widget.items.shadeField!=null?widget.items.shadeField:''),
                  ),


                  
                  Divider(),
                  ListTile(
                    title: Text("Warehouse Location"),
                    trailing: Text(widget.items.warehouseLocationField!=null?widget.items.warehouseLocationField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity in Pallet"),
                    trailing: Text(widget.items.salesQtyField!=null?widget.items.salesQtyField.toString():''),
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
