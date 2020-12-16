import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import  'package:flutter/material.dart';
import 'package:acmc_customer/Model/ProductionPlans.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/Production_Request/CreateProductionRequest.dart';
import 'package:acmc_customer/Production_Request/RequestList.dart';
class PlanDetail extends StatefulWidget {
 ProductionPlans planData;
 var customerId;
 PlanDetail(this.planData,this.customerId);

 @override
  _PlanDetailState createState() => _PlanDetailState(planData,customerId);
}

class _PlanDetailState extends State<PlanDetail> {
  ProductionPlans planData;
  var customerId;
  _PlanDetailState(this.planData,this.customerId);
 @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan Detail"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Create Production Request'){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateProductionRequest(customerId,null),
                    settings: RouteSettings(

                        arguments: {'month':planData.monthOfYear.toString()}
                    )));
              }else if(choice=='View Production Requests') {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>RequestList(planData.itemSize,planData.monthOfYear,customerId)));
              }
            },
            itemBuilder: (BuildContext context){
              return ['Create Production Request','View Production Requests'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },

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
                    trailing: Text(planData.whichYear!=null&&planData.monthOfYear!=null?planData.monthOfYear+' '+planData.whichYear.toString():''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Size Requested"),
                    trailing: Text(planData.itemSize!=null?planData.itemSize:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Requested Quantity"),
                    trailing: Text(planData.estimatedQuantity!=null?planData.estimatedQuantity.toString():''),
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

