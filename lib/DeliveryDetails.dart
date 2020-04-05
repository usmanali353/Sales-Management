import 'package:flutter/material.dart';

class DeliveryDetails extends StatefulWidget{
  var orders_data;

  DeliveryDetails(this.orders_data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeliveryDetails(orders_data);
  }

}
class _DeliveryDetails extends State<DeliveryDetails>{
  var orders_data;

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
      ),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])
        ),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Order id"),
              trailing: Text(orders_data['salesIdField']!=null?orders_data['salesIdField']:''),
            ),
            Divider(),
            ListTile(
              title: Text("Delivery Date"),
              trailing: Text(orders_data['deliveryDateField']!=null?orders_data['deliveryDateField']:''),
            ),
            Divider(),
            ListTile(
              title: Text("Truck Number"),
              trailing: Text(orders_data['truckPlateNumField']!=null?orders_data['truckPlateNumField']:''),
            ),
            Divider(),
            ListTile(
              title: Text("Truck Driver"),
              trailing: Text(orders_data['truckDriverField']!=null?orders_data['truckDriverField']:''),
            ),
            Divider(),
            ListTile(
              title: Text("Packing Slip #"),
              trailing: Text(orders_data['packingSlipNumField']!=null?orders_data['packingSlipNumField']:''),
            ),
            Divider(),
            ListTile(
              title: Text("Pallet Quantity"),
              trailing: Text(orders_data['quantityInPalletsField']!=null?orders_data['quantityInPalletsField'].toString():''),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

}