import 'package:flutter/material.dart';
class PrePickingDetails extends StatefulWidget {
  var prePickingData;

  PrePickingDetails(this.prePickingData);

  @override
  _PrePickingDetailsState createState() => _PrePickingDetailsState(prePickingData);
}

class _PrePickingDetailsState extends State<PrePickingDetails> {
  var prePickingData;

  _PrePickingDetailsState(this.prePickingData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PrePicking Details"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Picking Id"),
                subtitle: Text(prePickingData['PickingId']),
              ),
              Divider(),
              ListTile(
                title: Text("Status"),
                subtitle: Text(getStatus(prePickingData['Status'])),
              ),
              Divider(),
              ListTile(
                title: Text("Delivery Date"),
                subtitle: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(prePickingData['DeliveryDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
              ),
              Divider(),
              ListTile(
                title: Text("Address"),
                subtitle: Text(prePickingData['Address']),
              ),
              Divider(),
              ListTile(
                title: Text("Mobile No"),
                subtitle: Text(prePickingData['MobileNum']),
              ),
              Divider(),
              ListTile(
                title: Text("Driver Name"),
                subtitle: Text(prePickingData['DriverName']),
              ),
              Divider(),
              ListTile(
                title: Text("Truck Plate"),
                subtitle: Text(prePickingData['TruckPlate']),
              ),
              Divider(),
            ],
          )
        ],
      ),
    );
  }
  String getStatus(int status){
    String statusstr;
    if(status==0){
      statusstr="New Request";
    }else if(status==1){
      statusstr="Submitted";
    }else if(status==2){
      statusstr="Approved";
    }else if(status==3){
      statusstr="Rejected";
    }else {
      statusstr="Generate Picking List";
    }
    return statusstr;
  }
}
