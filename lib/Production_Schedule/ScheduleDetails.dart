import 'package:flutter/material.dart';
import 'package:salesmanagement/Model/ProductionSchedule.dart';

class ScheduleDetails extends StatefulWidget{
  ProductionSchedule scheduleData;

  ScheduleDetails(this.scheduleData);

  @override
  State<StatefulWidget> createState() {
    return _ScheduleDetails(scheduleData);
  }

}
class _ScheduleDetails extends State<ScheduleDetails>{
  ProductionSchedule scheduleData;

  _ScheduleDetails(this.scheduleData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule Detail")),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text("Item Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
                    title: Text("Item Id"),
                    trailing: Text(scheduleData.itemNumber!=null?scheduleData.itemNumber:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Name"),
                    subtitle: Text(scheduleData.itemDescription!=null?scheduleData.itemDescription:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Glazing"),
                    trailing: Text(scheduleData.glazingType!=null?scheduleData.glazingType:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Classification"),
                    trailing: Text(scheduleData.classification!=null?scheduleData.classification:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Packaging type"),
                    trailing: Text(scheduleData.packageName!=null?scheduleData.packageName:''),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text("Production Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
                    title: Text("Planned Production Date"),
                    trailing: Text(scheduleData.plannedProdDate!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(scheduleData.plannedProdDate.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Line Name"),
                    trailing: Text(scheduleData.productionLine!=null?scheduleData.productionLine:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Start Date"),
                    trailing: Text(!scheduleData.actualProdDate.contains('-22089564')?DateTime.fromMillisecondsSinceEpoch(int.parse(scheduleData.actualProdDate.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Days to Complete Production"),
                    trailing: Text(scheduleData.productionDays!=null?scheduleData.productionDays.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Number"),
                    trailing: Text(scheduleData.ppaNumber!=null?scheduleData.ppaNumber:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Status"),
                    trailing: Text(scheduleData.scheduleStatus!=null?scheduleData.scheduleStatus:''),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text("Production Quantity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
                    title: Text("Production Quantity Requested"),
                    trailing: Text(scheduleData.quantityRequested!=null?scheduleData.quantityRequested.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Actual Quantity Produced"),
                    trailing: Text(scheduleData.actualProductionQuantity!=null?scheduleData.actualProductionQuantity.toString():''),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
//          ListTile(
//            title: Text("Planned Production Date"),
//            subtitle: Text(scheduleData['PlannedProdDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(scheduleData['PlannedProdDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Production Line Name"),
//            subtitle: Text(scheduleData['ProductionLine']!=null?scheduleData['ProductionLine']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Production Quantity Requested"),
//            subtitle: Text(scheduleData['QuantityRequested']!=null?scheduleData['QuantityRequested'].toString():''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Actual Quantity Produced"),
//            subtitle: Text(scheduleData['ActualProductionQuantity']!=null?scheduleData['ActualProductionQuantity'].toString():''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Production Start Date"),
//            subtitle: Text(scheduleData['ActualProdDate']!=null?scheduleData['ActualProdDate']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Days to Complete Production"),
//            subtitle: Text(scheduleData['ProductionDays']!=null?scheduleData['ProductionDays'].toString():''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Production Number"),
//            subtitle: Text(scheduleData['PPANumber']!=null?scheduleData['PPANumber']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Production Status"),
//            subtitle: Text(scheduleData['ScheduleStatus']!=null?scheduleData['ScheduleStatus']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Item Id"),
//            subtitle: Text(scheduleData['ItemNumber']!=null?scheduleData['ItemNumber']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Item Name"),
//            subtitle: Text(scheduleData['ItemDescription']!=null?scheduleData['ItemDescription']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Tiles Glazing"),
//            subtitle: Text(scheduleData['GlazingType']!=null?scheduleData['GlazingType']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Tiles Classification"),
//            subtitle: Text(scheduleData['Classification']!=null?scheduleData['Classification']:''),
//          ),
//          Divider(),
//          ListTile(
//            title: Text("Packaging type"),
//            subtitle: Text(scheduleData['PackageName']!=null?scheduleData['PackageName']:''),
//          ),
//          Divider(),
        ],
      ),
    );
  }

}