import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Plan/CreateProductionPlan.dart';
import 'package:salesmanagement/Production_Plan/UpdateProductionPlan.dart';

import 'PlanDetails.dart';

class PlanList extends StatefulWidget{
  var planList,type,month,year,size,customerId;

  PlanList(this.type,this.year,this.month,this.size,this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _PlanList(type,year,month,size,customerId);
  }

}
class _PlanList extends ResumableState<PlanList>{
  var planList=[],temp=['',''],type,month,year,size,customerId,isvisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  _PlanList(this.type,this.year,this.month,this.size,this.customerId);
  @override
  void onResume() {
    print("Data "+resume.data.toString());
    if(resume.data.toString()=='Refresh') {
      WidgetsBinding.instance
          .addPostFrameCallback((_) =>
          _refreshIndicatorKey.currentState
              .show());
    }

  }
  @override
  void initState() {
   WidgetsBinding.instance
       .addPostFrameCallback((_) =>
       _refreshIndicatorKey.currentState
           .show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          push(context, MaterialPageRoute(builder: (context)=>CreateProductionPlan()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Plans"),
         actions: <Widget>[
           PopupMenuButton<String>(
             onSelected: (choice){
               if(choice=='By Size and Month'){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPlanByMonth()));
               }else if(choice=='By Size and Year'){
               //  Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPlanByYearAndSize()));
               }
             },
             itemBuilder: (BuildContext context){
               return ['By Size and Month','By Size and Year'].map((String choice){
                 return PopupMenuItem<String>(
                   value: choice,
                   child: Text(choice),
                 );
               }).toList();
             },
           ),
         ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          if(type=="All"){
               return Network_Operations.GetCustomerPlan(customerId, year).then((response){
            if(response!=null&&response!=''&&response!='[]'){
              setState(() {
                this.planList=jsonDecode(response);
                this.isvisible=true;
                print(planList.length.toString());
              });
            }
          });
          }else if(type=="Size and Year"){
            return Network_Operations.GetCustomerPlanBySize(customerId, size, year).then((response){
              if(response!=null&&response!=''&&response!='[]'){
                setState(() {
                  this.planList=jsonDecode(response);
                  this.isvisible=true;
                });
              }
            });
          }else
            return Network_Operations.GetCustomerPlanByMonthSize(customerId, size, year, month).then((response){
              if(response!=null&&response!=''&&response!='[]'){
                setState(() {
                  this.planList=jsonDecode(response);
                  this.isvisible=true;
                });
              }
            });
        },
        child: Visibility(
          visible: isvisible,
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
                          push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(planList[index]['ItemSize']!=null?planList[index]['ItemSize']:''),
                      subtitle: Text(planList[index]['EstimatedQuantity']!=null?"Requested Quantity "+planList[index]['EstimatedQuantity'].toString():''),
                      leading: Icon(FontAwesomeIcons.tasks,size: 30,),
                      onTap: (){
                        push(context,MaterialPageRoute(builder: (context)=>PlanDetail(planList[index])));
                      },
                    )
                ),
                Divider(),
              ],
            ) ;
          }),
        ),
      ),
    );

  }

}