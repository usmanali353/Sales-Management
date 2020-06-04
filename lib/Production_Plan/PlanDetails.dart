import 'dart:convert';

import  'package:flutter/material.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/CreateProductionRequest.dart';
class PlanDetail extends StatefulWidget {
 var planData;

 PlanDetail(this.planData);

 @override
  _PlanDetailState createState() => _PlanDetailState(planData);
}

class _PlanDetailState extends State<PlanDetail> {
  var planData;

  _PlanDetailState(this.planData);
 @override
  void initState() {
   Network_Operations.GetProdRequestListBySize('LC0001', planData['ItemSize'], 1, 100).then((value){
     if(value!=null){
       var requestBysize=jsonDecode(value);
     }
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Detail"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateProductionRequest(),
                  settings: RouteSettings(
                      arguments: {'month':planData['MonthOfYear'].toString()}
                  )));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Create Production Request"),
              ),
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
                    title: Text("Plan Month"),
                    subtitle: Text(planData['WhichYear']!=null&&planData['MonthOfYear']!=null?planData['MonthOfYear']+' '+planData['WhichYear'].toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Size Requested"),
                    subtitle: Text(planData['ItemSize']!=null?planData['ItemSize']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Requested Quantity"),
                    subtitle: Text(planData['EstimatedQuantity']!=null?planData['EstimatedQuantity'].toString():''),
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

