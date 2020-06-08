import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Plan/CreateProductionPlan.dart';
import 'package:salesmanagement/Production_Plan/UpdateProductionPlan.dart';
import 'package:salesmanagement/Utils.dart';

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
  int yearSum=0, janSum=0,febSum=0,marSum=0,aprSum=0,maySum=0,juneSum=0,julSum=0,augSum=0,sepSum=0,octSum=0,novSum=0,decSum=0;
  var planList=[],temp=['',''],type,month,year,size,customerId,isvisible=false,currentSelectedValue;
   List<String> deviceTypes=[];
  _PlanList(this.type,this.year,this.month,this.size,this.customerId);
  @override
  void onResume() {
    print("Data "+resume.data.toString());
    if(resume.data.toString()=='Refresh') {
      Network_Operations.GetCustomerPlan(customerId,year).then((response){
        if(response!=null){
          setState(() {
            planList=jsonDecode(response);
            isvisible=true;
            janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

            for (int index = 0; index < planList.length; index++) {
              yearSum=yearSum+planList[index]['EstimatedQuantity'];
              if (planList[index]['MonthOfYear'] == 'January') {
                janSum = janSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'Febuary') {
                febSum = febSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'March') {
                marSum = marSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'April') {
                aprSum = aprSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'May') {
                maySum = maySum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'June') {
                juneSum = juneSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'July') {
                julSum = julSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'August') {
                augSum = augSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'September') {
                sepSum = sepSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'October') {
                octSum = octSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'November') {
                novSum = novSum + planList[index]['EstimatedQuantity'];
              }else if (planList[index]['MonthOfYear'] == 'December') {
                decSum = decSum + planList[index]['EstimatedQuantity'];
              }
            }
          });
        }
      });
    }

  }
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        Network_Operations.GetCustomerPlan(customerId,year).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              planList=jsonDecode(response);
              isvisible=true;
              janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

              for (int index = 0; index < planList.length; index++) {
                yearSum=yearSum+planList[index]['EstimatedQuantity'];
                if (planList[index]['MonthOfYear'] == 'January') {
                  janSum = janSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'Febuary') {
                  febSum = febSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'March') {
                  marSum = marSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'April') {
                  aprSum = aprSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'May') {
                  maySum = maySum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'June') {
                  juneSum = juneSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'July') {
                  julSum = julSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'August') {
                  augSum = augSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'September') {
                  sepSum = sepSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'October') {
                  octSum = octSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'November') {
                  novSum = novSum + planList[index]['EstimatedQuantity'];
                }else if (planList[index]['MonthOfYear'] == 'December') {
                  decSum = decSum + planList[index]['EstimatedQuantity'];
                }
              }
            });
          }
        });
      }else{
        Flushbar(
          message: "Network not Available",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    });

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
        title: Text("Production Plans"),
         actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Utils.check_connectivity().then((connected){
                if(connected){
                  ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                  pd.show();
                  Network_Operations.GetItemSizes().then((response){
                    pd.dismiss();
                    if(response!=null){
                      setState(() {
                        var sizes=jsonDecode(response);
                        if(sizes!=null&&sizes.length>0) {
                          for (int i = 1; i < sizes.length; i++) {
                            deviceTypes.add(sizes[i]['ItemSize']);
                          }
                          showAlertDialog(context);
                        }
                      });
                    }
                  });
                }
              });
            },
          )
         ],
      ),
        body: Visibility(
          visible: isvisible,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: ListView(
                children: <Widget>[
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: Text('January'),
                    subtitle: Text("Total Quantity: $janSum"),
                    children: januaryList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('Febuary'),
                      subtitle: Text("Total Quantity: $febSum"),
                    children: febuaryList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('March'),
                      subtitle: Text("Total Quantity: $marSum"),
                    children: MarchList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('April'),
                      subtitle: Text("Total Quantity: $aprSum"),
                    children: AprilList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('May'),
                      subtitle: Text("Total Quantity: $maySum"),
                    children: MayList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('June'),
                      subtitle: Text("Total Quantity: $juneSum"),
                    children: JuneList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('July'),
                      subtitle: Text("Total Quantity: $julSum"),
                    children: JulyList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('August'),
                      subtitle: Text("Total Quantity: $augSum"),
                    children: AugustList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('September'),
                      subtitle: Text("Total Quantity: $sepSum"),
                    children: SeptemberList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('October'),
                      subtitle: Text("Total Quantity: $octSum"),
                    children: OctoberList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('November'),
                      subtitle: Text("Total Quantity: $novSum"),
                    children: NovemberList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('December'),
                      subtitle: Text("Total Quantity: $decSum"),
                    children: DecemberList()
                  ),
                  ExpansionTile(
                      initiallyExpanded: true,
                    title: Text('Whole Year'),
                      subtitle: Text("Total Quantity: $yearSum"),
                    children: wholeYear()
                  ),
                ],
              ),
            ),
          ),
        ),
//      body: RefreshIndicator(
//        key: _refreshIndicatorKey,
//        onRefresh: (){
//          if(type=="All"){
//               return Network_Operations.GetCustomerPlan(customerId, year).then((response){
//            if(response!=null&&response!=''&&response!='[]'){
//              setState(() {
//                this.planList=jsonDecode(response);
//                this.isvisible=true;
//                print(planList.length.toString());
//              });
//            }
//          });
//          }else if(type=="Size and Year"){
//            return Network_Operations.GetCustomerPlanBySize(customerId, size, year).then((response){
//              if(response!=null&&response!=''&&response!='[]'){
//                setState(() {
//                  this.planList=jsonDecode(response);
//                  this.isvisible=true;
//                });
//              }
//            });
//          }else
//            return Network_Operations.GetCustomerPlanByMonthSize(customerId, size, year, month).then((response){
//              if(response!=null&&response!=''&&response!='[]'){
//                setState(() {
//                  this.planList=jsonDecode(response);
//                  this.isvisible=true;
//                });
//              }
//            });
//        },
//        child: Visibility(
//          visible: isvisible,
//          child: Padding(
//            padding: const EdgeInsets.all(16),
//            child: Card(
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(15.0),
//              ),
//              elevation: 10,
//              child: ListView.builder(itemCount: planList!=null?planList.length:temp.length,itemBuilder: (context,int index){
//                return Column(
//                  children: <Widget>[
//                    Slidable(
//                        actionPane: SlidableDrawerActionPane(),
//                        actionExtentRatio: 0.20,
//                        actions: <Widget>[
//                          IconSlideAction(
//                            icon: Icons.delete,
//                            color: Colors.red,
//                            caption: 'Delete',
//                            onTap: (){
//                              ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
//                              pd.show();
//                              Network_Operations.DeleteCustomerPlan(planList[index]['RecordId']).then((response){
//                                pd.dismiss();
//                                if(response!=null){
//                                  WidgetsBinding.instance
//                                      .addPostFrameCallback((_) =>
//                                      _refreshIndicatorKey.currentState
//                                          .show());
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor: Colors.green,
//                                    content: Text("Plan Deleted Sucessfully"),
//                                  ));
//                                }else{
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor: Colors.red,
//                                    content: Text("Plan not Deleted"),
//                                  ));
//                                }
//                              });
//                            },
//                          ),
//                          IconSlideAction(
//                            icon: Icons.edit,
//                            color: Colors.blue,
//                            caption: 'Update',
//                            onTap: (){
//                              push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
//                            },
//                          ),
//                        ],
//                        child: ListTile(
//                          title: Text(planList[index]['ItemSize']!=null?planList[index]['ItemSize']:''),
//                          subtitle: Text(planList[index]['EstimatedQuantity']!=null?"Quantity:"+planList[index]['EstimatedQuantity'].toString():''),
//                          trailing: Text(planList[index]['WhichYear']!=null&&planList[index]['MonthOfYear']!=null?planList[index]['MonthOfYear']+' '+planList[index]['WhichYear'].toString():''),
//                          leading:  Material(
//                              borderRadius: BorderRadius.circular(24),
//                              color: Colors.teal.shade100,
//                              child: Padding(
//                                padding: const EdgeInsets.only(top:10,bottom: 15,right: 10,left: 10),
//                                child: Icon(FontAwesomeIcons.tasks,size: 25,color: Color(0xFF004c4c),),
//                              )
//                          ),
//                          onTap: (){
//                            push(context,MaterialPageRoute(builder: (context)=>PlanDetail(planList[index])));
//                          },
//                        )
//                    ),
//                    Divider(),
//                  ],
//                ) ;
//              }),
//            ),
//          ),
//        ),
//      ),
    );

  }
List<Widget> wholeYear() {

  List<Widget> columnContent = [];
  for (int index = 0; index < planList.length; index++) {

    columnContent.add(ListTile(
      title: Text(planList[index]['ItemSize'] != null
          ? planList[index]['ItemSize']
          : ''),
      subtitle: Text(
          planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
              planList[index]['EstimatedQuantity'].toString() : ''),
      trailing: Text(planList[index]['WhichYear'] != null &&
          planList[index]['MonthOfYear'] != null
          ? planList[index]['MonthOfYear'] + ' ' +
          planList[index]['WhichYear'].toString()
          : ''),
      leading: Material(
          borderRadius: BorderRadius.circular(24),
          color: Colors.teal.shade100,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 15, right: 10, left: 10),
            child: Icon(
              FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
          )
      ),
      onTap: () {
        push(context, MaterialPageRoute(
            builder: (context) => PlanDetail(planList[index])));
      },
    ));

  }
  return columnContent;
}
  List<Widget> januaryList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {

      if(planList[index]['MonthOfYear']=='January'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> febuaryList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='Febuary'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> MarchList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='March'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> AprilList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='April'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> MayList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='May'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> JuneList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='June'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> JulyList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='July'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> AugustList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='August'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> SeptemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='September'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> OctoberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='October'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> NovemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='November'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  List<Widget> DecemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index]['MonthOfYear']=='December'){
        columnContent.add(ListTile(
          title: Text(planList[index]['ItemSize'] != null
              ? planList[index]['ItemSize']
              : ''),
          subtitle: Text(
              planList[index]['EstimatedQuantity'] != null ? "Quantity:" +
                  planList[index]['EstimatedQuantity'].toString() : ''),
          trailing: Text(planList[index]['WhichYear'] != null &&
              planList[index]['MonthOfYear'] != null
              ? planList[index]['MonthOfYear'] + ' ' +
              planList[index]['WhichYear'].toString()
              : ''),
          leading: Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, right: 10, left: 10),
                child: Icon(
                  FontAwesomeIcons.tasks, size: 25, color: Color(0xFF004c4c),),
              )
          ),
          onTap: () {
            push(context, MaterialPageRoute(
                builder: (context) => PlanDetail(planList[index])));
          },
        ));
      }


    }
    return columnContent;
  }
  Widget typeFieldWidget() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  border: InputBorder.none),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text("Select Size"),
                  isDense: true,
                  onChanged: (newValue) {
                    setState(() {
                      currentSelectedValue = newValue;
                      Navigator.pop(context);
                      if(currentSelectedValue=='All'){
                        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                        pd.show();
                        Network_Operations.GetCustomerPlan(customerId,year).then((response){
                          pd.dismiss();
                          if(response!=null){
                            setState(() {
                              planList=jsonDecode(response);
                              isvisible=true;
                              janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

                              for (int index = 0; index < planList.length; index++) {
                                yearSum=yearSum+planList[index]['EstimatedQuantity'];
                                if (planList[index]['MonthOfYear'] == 'January') {
                                  janSum = janSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'Febuary') {
                                  febSum = febSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'March') {
                                  marSum = marSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'April') {
                                  aprSum = aprSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'May') {
                                  maySum = maySum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'June') {
                                  juneSum = juneSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'July') {
                                  julSum = julSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'August') {
                                  augSum = augSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'September') {
                                  sepSum = sepSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'October') {
                                  octSum = octSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'November') {
                                  novSum = novSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'December') {
                                  decSum = decSum + planList[index]['EstimatedQuantity'];
                                }
                              }
                            });
                          }
                        });
                      }else{
                        Network_Operations.GetCustomerPlanBySize(customerId, currentSelectedValue, year).then((response){
                          if(response!=null){
                            setState(() {
                              planList=jsonDecode(response);
                              janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

                              for (int index = 0; index < planList.length; index++) {
                                yearSum=yearSum+planList[index]['EstimatedQuantity'];
                                if (planList[index]['MonthOfYear'] == 'January') {
                                  janSum = janSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'Febuary') {
                                  febSum = febSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'March') {
                                  marSum = marSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'April') {
                                  aprSum = aprSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'May') {
                                  maySum = maySum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'June') {
                                  juneSum = juneSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'July') {
                                  julSum = julSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'August') {
                                  augSum = augSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'September') {
                                  sepSum = sepSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'October') {
                                  octSum = octSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'November') {
                                  novSum = novSum + planList[index]['EstimatedQuantity'];
                                }else if (planList[index]['MonthOfYear'] == 'December') {
                                  decSum = decSum + planList[index]['EstimatedQuantity'];
                                }
                              }
                            });
                          }
                        });
                      }

                    });
                  },
                  items: deviceTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Select Item Size"),
      content: typeFieldWidget(),
      actions: [
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}