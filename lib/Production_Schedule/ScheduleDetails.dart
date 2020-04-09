import 'package:flutter/material.dart';

class ScheduleDetails extends StatefulWidget{
  var scheduleData;

  ScheduleDetails(this.scheduleData);

  @override
  State<StatefulWidget> createState() {
    return _ScheduleDetails(scheduleData);
  }

}
class _ScheduleDetails extends State<ScheduleDetails>{
  var scheduleData;

  _ScheduleDetails(this.scheduleData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule Detail"),),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Planned Production Date"),
            subtitle: Text(scheduleData['PlannedProdDate']!=null?scheduleData['PlannedProdDate']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Production Line Name"),
            subtitle: Text(scheduleData['ProductionLine']!=null?scheduleData['ProductionLine']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Production Quantity Requested"),
            subtitle: Text(scheduleData['QuantityRequested']!=null?scheduleData['QuantityRequested'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Actual Quantity Produced"),
            subtitle: Text(scheduleData['ActualProductionQuantity']!=null?scheduleData['ActualProductionQuantity'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Production Start Date"),
            subtitle: Text(scheduleData['ActualProdDate']!=null?scheduleData['ActualProdDate']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Days to Complete Production"),
            subtitle: Text(scheduleData['ProductionDays']!=null?scheduleData['ProductionDays'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Production Number"),
            subtitle: Text(scheduleData['PPANumber']!=null?scheduleData['PPANumber']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Production Status"),
            subtitle: Text(scheduleData['ScheduleStatus']!=null?scheduleData['ScheduleStatus']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Item Id"),
            subtitle: Text(scheduleData['ItemNumber']!=null?scheduleData['ItemNumber']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Item Name"),
            subtitle: Text(scheduleData['ItemDescription']!=null?scheduleData['ItemDescription']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Tiles Glazing"),
            subtitle: Text(scheduleData['GlazingType']!=null?scheduleData['GlazingType']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Tiles Classification"),
            subtitle: Text(scheduleData['Classification']!=null?scheduleData['Classification']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Packaging type"),
            subtitle: Text(scheduleData['PackageName']!=null?scheduleData['PackageName']:''),
          ),
          Divider(),
        ],
      ),
    );
  }

}