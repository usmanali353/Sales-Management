import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/CaseDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Plan/UpdateProductionPlan.dart';

import 'PlanDetails.dart';

class PlanList extends StatefulWidget{
  var planList,type,month,year,size,customerId;

  PlanList(this.planList,this.type,this.year,this.month,this.size,this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _PlanList(planList,type,month,year,size,customerId);
  }

}
class _PlanList extends State<PlanList>{
  var planList,temp=['',''],type,month,year,size,customerId;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  _PlanList(this.planList,this.type,this.year,this.month,this.size,this.customerId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plans"),),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          if(type=="All"){
            return Network_Operations.GetCustomerPlan(customerId, year).then((response){
              if(response!=null&&response!=''&&response!='[]'){
                setState(() {
                  this.planList=jsonDecode(response);
                });
              }
            });
          }else if(type=="Size and Year"){
            return Network_Operations.GetCustomerPlanBySize(customerId, size, year).then((response){
              if(response!=null&&response!=''&&response!='[]'){
                setState(() {
                  this.planList=jsonDecode(response);
                });
              }
            });
          }else
            return Network_Operations.GetCustomerPlanByMonthSize(customerId, size, year, month).then((response){
              if(response!=null&&response!=''&&response!='[]'){
                setState(() {
                  this.planList=jsonDecode(response);
                });
              }
            });
        },
        child: ListView.builder(itemCount: planList!=null?planList.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[
              Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.delete,
                      color: Colors.red,
                      caption: 'Delete',
                      onTap: (){
                        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                        pd.show();
                        Network_Operations.DeleteCustomerPlan(planList[index]['RecordId']).then((response){
                          pd.dismiss();
                          if(response!=null){
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) =>
                                _refreshIndicatorKey.currentState
                                    .show());
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Plan Deleted Sucessfully"),
                            ));
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Plan not Deleted"),
                            ));
                          }
                        });
                      },
                    ),
                    IconSlideAction(
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(planList[index]['ItemSize']!=null?planList[index]['ItemSize']:''),
                    subtitle: Text(planList[index]['EstimatedQuantity']!=null?"Requested Quantity "+planList[index]['EstimatedQuantity'].toString():''),
                    leading: Icon(FontAwesomeIcons.tasks,size: 30,),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>PlanDetail(planList[index])));
                    },
                  )
              ),
              Divider(),
            ],
          ) ;
        }),
      ),
    );

  }

}