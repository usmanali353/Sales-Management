import 'package:flutter/material.dart';
import 'package:acmc_customer/Model/Deliveries.dart';

import 'SalesLinesItemsList.dart';

class DeliveryDetails extends StatefulWidget{
  Deliveries orders_data;

  DeliveryDetails(this.orders_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeliveryDetails(orders_data);
  }

}
class _DeliveryDetails extends State<DeliveryDetails>{
  Deliveries orders_data;

  _DeliveryDetails(this.orders_data);
  @override
  void initState() {
    print(orders_data.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Details"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              child: Center(
                child: Text(
                  "View Sales Lines"
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesLinesItemsList(orders_data.salesIdField)));
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
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
                    title: Text("Packing Slip #"),
                    trailing: Text(orders_data.packingSlipNumField!=null?orders_data.packingSlipNumField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Packing Slip Generation"),
                    trailing: Text(orders_data.packingSlipGenerateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data.packingSlipGenerateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Pallet Quantity"),
                    trailing: Text(orders_data.quantityInPalletsField!=null?orders_data.quantityInPalletsField.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity in SQM"),
                    trailing: Text(orders_data.quantityInSqmField!=null?orders_data.quantityInSqmField.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Delivery Date"),
                    trailing: Text(orders_data.deliveryDateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data.deliveryDateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Truck Number"),
                    trailing: Text(orders_data.truckPlateNumField!=null?orders_data.truckPlateNumField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Truck Driver"),
                    trailing: Text(orders_data.truckDriverField!=null?orders_data.truckDriverField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Driver Mobile"),
                    trailing: Text(orders_data.mobileField!=null?orders_data.mobileField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Ticket #"),
                    trailing: Text(orders_data.ticketField!=null?orders_data.ticketField:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Loading Start"),
                    trailing: Text(orders_data.startLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data.startLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Loading End"),
                    trailing: Text(orders_data.stopLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data.stopLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
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