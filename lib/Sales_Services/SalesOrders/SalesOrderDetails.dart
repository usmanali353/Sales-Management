import 'package:flutter/material.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/SalesLinesItemsList.dart';

class salesOrdersDetails extends StatefulWidget{
  var order_data;

  salesOrdersDetails(this.order_data);

  @override
  State<StatefulWidget> createState() {
    return _salesOrdersDetails(this.order_data);
  }

}
class _salesOrdersDetails extends State<salesOrdersDetails>{
  var order_data;
  _salesOrdersDetails(this.order_data);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sales Order Details"),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesLinesItemsList(order_data['salesIdField'])));
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Column(
               children: <Widget>[
                 ListTile(
                   title: Text("Customer Name"),
                   subtitle: Text(order_data['salesNameField']!=null?order_data['salesNameField']:''),
                 ),
                 Divider(),
                 ListTile(
                   title: Text("Delivery Name"),
                   subtitle: Text(order_data['deliveryNameField']!=null?order_data['deliveryNameField']:''),
                 ),
                 Divider(),
                 ListTile(
                   title: Text("Delivery Mode"),
                   trailing: Text(order_data['deliveryModeField']!=null?order_data['deliveryModeField']:''),
                 ),
                 Divider(),
                 ListTile(
                   title: Text("Sales Status"),
                   trailing: Text(order_data['salesStatusField']!=null?get_order_status(order_data['salesStatusField']):''),
                 ),
                 Divider(),
               ],
              )
            ),
          )

        ],
      )
    );
  }
  String get_order_status(int num){
    String status="";
    if(num==0){
      status="None";
    }else if(num==1){
      status="Backorder";
    }else if(num==2){
      status="Delivered";
    }else if(num==3){
      status="Invoiced";
    }else if(num==4){
      status="Canceled";
    }
    return status;
  }

}