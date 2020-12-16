import 'package:flutter/material.dart';
import 'package:acmc_customer/PrePicking/OrderedProducts.dart';

class PrePickingDetails extends StatefulWidget {
  var prePickingData;

  PrePickingDetails(this.prePickingData);

  @override
  _PrePickingDetailsState createState() =>
      _PrePickingDetailsState(prePickingData);
}

class _PrePickingDetailsState extends State<PrePickingDetails> {
  var prePickingData;

  _PrePickingDetailsState(this.prePickingData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          InkWell(
            child: Center(child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text("View Ordered Items"),
            )),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderedProducts(prePickingData)));
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text(
                "Order Info",
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
                    title: Text("Order Id"),
                    trailing: Text(prePickingData['PickingId']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Address"),
                    trailing: Text(prePickingData['Address']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Delivery Date"),
                    trailing: Text(DateTime.fromMillisecondsSinceEpoch(
                            int.parse(prePickingData['DeliveryDate']
                                .replaceAll('/Date(', '')
                                .replaceAll(')/', '')
                                .replaceAll('+0300', '')))
                        .toString()
                        .split(' ')[0]),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Status"),
                    trailing: Text(getStatus(prePickingData['Status'])),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text(
              "Driver Info",
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
                    title: Text("Driver Name"),
                    trailing: Text(prePickingData['DriverName']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Mobile No"),
                    trailing: Text(prePickingData['MobileNum']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Truck Plate"),
                    trailing: Text(prePickingData['TruckPlate']),
                  ),
                  Divider()
                ],
              ),
            ),
          ),

//
//          ListTile(
//            title: Text("Picking Id"),
//            subtitle: Text(prePickingData['PickingId']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Status"),
//            subtitle: Text(getStatus(prePickingData['Status'])),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Delivery Date"),
//            subtitle: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(prePickingData['DeliveryDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Address"),
//            subtitle: Text(prePickingData['Address']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Mobile No"),
//            subtitle: Text(prePickingData['MobileNum']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Driver Name"),
//            subtitle: Text(prePickingData['DriverName']),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Truck Plate"),
//            subtitle: Text(prePickingData['TruckPlate']),
//          ),
//          Divider()
        ],
      ),
    );
  }

  String getStatus(int status) {
    String statusstr;
    if (status == 0) {
      statusstr = "New Request";
    } else if (status == 1) {
      statusstr = "Submitted";
    } else if (status == 2) {
      statusstr = "Approved";
    } else if (status == 3) {
      statusstr = "Rejected";
    } else {
      statusstr = "Generate Picking List";
    }
    return statusstr;
  }
}
