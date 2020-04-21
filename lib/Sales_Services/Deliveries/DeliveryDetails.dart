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
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Order id"),
            subtitle: Text(orders_data['salesIdField']!=null?orders_data['salesIdField']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Delivery Date"),
            subtitle: Text(orders_data['deliveryDateField']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data['deliveryDateField'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
          ),
          Divider(),
          ListTile(
            title: Text("Truck Number"),
            subtitle: Text(orders_data['truckPlateNumField']!=null?orders_data['truckPlateNumField']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Truck Driver"),
            subtitle: Text(orders_data['truckDriverField']!=null?orders_data['truckDriverField']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Packing Slip #"),
            subtitle: Text(orders_data['packingSlipNumField']!=null?orders_data['packingSlipNumField']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Pallet Quantity"),
            subtitle: Text(orders_data['quantityInPalletsField']!=null?orders_data['quantityInPalletsField'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Quantity in SQM"),
            subtitle: Text(orders_data['quantityInSQMField']!=null?orders_data['quantityInSQMField'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Line Number"),
            subtitle: Text(orders_data['lineNumField']!=null?orders_data['lineNumField'].toString():''),
          ),
          Divider(),
        ],
      ),
    );
  }

}