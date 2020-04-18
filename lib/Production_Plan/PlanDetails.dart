import  'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plan Detail"),),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Customer Account"),
            subtitle: Text(planData['CustomerAccount']!=null?planData['CustomerAccount'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Plan Year"),
            subtitle: Text(planData['WhichYear']!=null?planData['WhichYear'].toString():''),
          ),
          Divider(),
          ListTile(
            title: Text("Plan Month"),
            subtitle: Text(planData['MonthOfYear']!=null?planData['MonthOfYear']:''),
          ),
          Divider(),
          ListTile(
            title: Text("Size of Requested Item"),
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
    );
  }
}

