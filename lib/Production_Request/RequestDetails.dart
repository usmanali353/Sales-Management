import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Schedule/ScheduleDetails.dart';

class RequestDetails extends StatefulWidget{
  var requestData;

  RequestDetails(this.requestData);

  @override
  State<StatefulWidget> createState() {
    return _RequestDetails(requestData);
  }

}
class _RequestDetails extends State<RequestDetails>{
  var requestData;

  _RequestDetails(this.requestData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Production Request Details"),
        actions: <Widget>[
          requestData['ProductionStatus']!='Requested'?
            Padding(
              padding: const EdgeInsets.all(16),
              child: InkWell(
                child: Center(child: Text("View Schedule")),
                onTap: () {
                  try {
                    Network_Operations.GetProductionScheduleByRequest(
                        requestData['ProductionRequestId']).then((response) {
                          if(response!=null){
                            var schedulebyRequest = jsonDecode(response);
                            if (schedulebyRequest != null) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      ScheduleDetails(schedulebyRequest)));
                          }else{
                              Flushbar(
                                message: "Not Found",
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 5),
                              )
                                ..show(context);
                            }

                      } else {
                        Flushbar(
                          message: "Not Found",
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 5),
                        )
                          ..show(context);
                      }
                    });
                  } catch (e) {
                    Flushbar(
                      message: "Not Found",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )
                      ..show(context);
                  }
                },
              ),
            ):Container(),

        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text("Requested Item Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
                    title: Text("Item Number"),
                    subtitle: Text(requestData['ItemNumber']!=null?requestData['ItemNumber']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Name"),
                    subtitle: Text(requestData['ItemDescription']!=null?requestData['ItemDescription']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Item Size"),
                    subtitle: Text(requestData['ItemSize']!=null?requestData['ItemSize']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Customer Item Code"),
                    subtitle: Text(requestData['CustomerItemCode']!=null?requestData['CustomerItemCode']:''),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text("Request Info",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          ),
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
                    title: Text("Request Id"),
                    subtitle: Text(requestData['ProductionRequestId']!=null?requestData['ProductionRequestId']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Request Date"),
                    subtitle: Text(requestData['RequestedDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(requestData['RequestedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Quantity Requested"),
                    subtitle: Text(requestData['QuantityRequested'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Approval Date"),
                    subtitle: Text(!requestData['ApprovalDate'].contains("-22089564")?DateTime.fromMillisecondsSinceEpoch(int.parse(requestData['ApprovalDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Planned Production Date"),
                    subtitle: Text(!requestData['PlannedDate'].contains("-22089564")?DateTime.fromMillisecondsSinceEpoch(int.parse(requestData['PlannedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Number"),
                    subtitle: Text(requestData['PPANumber']!=null?requestData['PPANumber']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Request Status"),
                    subtitle: Text(requestData['ProductionStatus']!=null?requestData['ProductionStatus']:''),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),

          Center(
            child: Text("Items Produced",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
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
                    title: Text("G1 Grade Quantity Produced"),
                    subtitle: Text(requestData['QuantityG1Produced'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("MS Grade Quantity Produced"),
                    subtitle: Text(requestData['QuantityMSProduced'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Total Quantity Produced"),
                    subtitle: Text(requestData['QuantityProduced'].toString()),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
//          Column(
//            children: <Widget>[
//
//              ListTile(
//                title: Text("Request Date"),
//                subtitle: Text(requestData['RequestedDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(requestData['RequestedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Request Id"),
//                subtitle: Text(requestData['ProductionRequestId']!=null?requestData['ProductionRequestId']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Request Status"),
//                subtitle: Text(requestData['ProductionStatus']!=null?requestData['ProductionStatus']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Approval Date"),
//                subtitle: Text(requestData['ApprovalDate']!=null?requestData['ApprovalDate']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Item Number"),
//                subtitle: Text(requestData['ItemNumber']!=null?requestData['ItemNumber']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Item Name"),
//                subtitle: Text(requestData['ItemDescription']!=null?requestData['ItemDescription']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Item Size"),
//                subtitle: Text(requestData['ItemSize']!=null?requestData['ItemSize']:''),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Quantity Requested"),
//                subtitle: Text(requestData['QuantityRequested'].toString()),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("G1 Quantity Produced"),
//                subtitle: Text(requestData['QuantityG1Produced'].toString()),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("MS Quantity Produced"),
//                subtitle: Text(requestData['QuantityMSProduced'].toString()),
//              ),
//              Divider(),
//              ListTile(
//                title: Text("Total Quantity Produced"),
//                subtitle: Text(requestData['QuantityProduced'].toString()),
//              ),
//              Divider(),
//            ],
//          )

        ],
      ),
    );
  }

}