import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Model/ItemSizes.dart';
import 'package:acmc_customer/Model/ProductionPlans.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/Production_Plan/CreateProductionPlan.dart';
import 'package:acmc_customer/Production_Plan/UpdateProductionPlan.dart';
import 'package:acmc_customer/Utils.dart';

import 'PlanDetails.dart';

class PlanList extends StatefulWidget{
  var type,month,year,size,customerId;
  List<ProductionPlans>planList=[];
  PlanList(this.type,this.year,this.month,this.size,this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _PlanList(type,year,month,size,customerId);
  }

}
class _PlanList extends ResumableState<PlanList>{
  int yearSum=0, janSum=0,febSum=0,marSum=0,aprSum=0,maySum=0,juneSum=0,julSum=0,augSum=0,sepSum=0,octSum=0,novSum=0,decSum=0;
  var temp=['',''],type,month,year,size,customerId,isvisible=false,currentSelectedValue;
  List<ProductionPlans>planList=[];
   List<String> deviceTypes=[];
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
          push(context, MaterialPageRoute(builder: (context)=>CreateProductionPlan(customerId)));
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
                  Network_Operations.GetItemSizes(context).then((response){
                    if(response!=null){
                      setState(() {
                        List<ItemSizes> sizes=response;
                        if(sizes!=null&&sizes.length>0) {
                          for (int i = 1; i < sizes.length; i++) {
                            deviceTypes.add(sizes[i].itemSize);
                          }
                          showAlertDialog(context);
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
            },
          )
         ],
      ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: (){
            return  Utils.check_connectivity().then((connected){
              if(connected){
                Network_Operations.GetCustomerPlan(context,customerId,year).then((plans){
                  if(plans!=null&&plans.length>0){
                    setState(() {
                      if(planList!=null){
                        planList.clear();
                      }
                      planList=plans;
                      isvisible=true;
                      janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

                      for (int index = 0; index < planList.length; index++) {
                        yearSum=yearSum+planList[index].estimatedQuantity;
                        if (planList[index].monthOfYear == 'January') {
                          janSum = janSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'Febuary') {
                          febSum = febSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'March') {
                          marSum = marSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'April') {
                          aprSum = aprSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'May') {
                          maySum = maySum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'June') {
                          juneSum = juneSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'July') {
                          julSum = julSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'August') {
                          augSum = augSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'September') {
                          sepSum = sepSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'October') {
                          octSum = octSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'November') {
                          novSum = novSum + planList[index].estimatedQuantity;
                        }else if (planList[index].monthOfYear == 'December') {
                          decSum = decSum + planList[index].estimatedQuantity;
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
          },
          child: Visibility(
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
        ),
    );

  }
List<Widget> wholeYear() {

  List<Widget> columnContent = [];
  for (int index = 0; index < planList.length; index++) {

    columnContent.add(
        Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.20,
            closeOnScroll: true,
            actions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                caption: "Delete",
                closeOnTap: true,
                onTap: (){
                  Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                    if(response!=null){
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) =>
                          _refreshIndicatorKey.currentState
                              .show());
                      Flushbar(
                        message: "Production Plan Deleted",
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 5),
                      )..show(context);
                    }else{
                      Flushbar(
                        message: "Production Plan not Deleted",
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      )..show(context);
                    }
                  });
                },
              ),
              IconSlideAction(
                color: Colors.blue,
                icon: Icons.edit,
                caption: "Update",
                closeOnTap: true,
                onTap: (){
                  push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
                },
              ),
            ],
        child:ListTile(
      title: Text(planList[index].itemSize != null
          ? planList[index].itemSize
          : ''),
      subtitle: Text(
          planList[index].estimatedQuantity != null ? "Quantity:" +
              planList[index].estimatedQuantity.toString() : ''),
      trailing: Text(planList[index].whichYear != null &&
          planList[index].monthOfYear != null
          ? planList[index].monthOfYear + ' ' +
          planList[index].whichYear.toString()
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
            builder: (context) => PlanDetail(planList[index],customerId)));
      },
    )
        )
    );

  }
  return columnContent;
}
  List<Widget> januaryList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {

      if(planList[index].monthOfYear=='January'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                   Flushbar(
                     message: "Production Plan Deleted",
                     backgroundColor: Colors.green,
                     duration: Duration(seconds: 5),
                   )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
              push(context, MaterialPageRoute(builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> febuaryList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='Febuary'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> MarchList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='March'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> AprilList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='April'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> MayList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='May'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> JuneList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='June'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> JulyList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='July'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> AugustList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='August'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> SeptemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='September'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> OctoberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='October'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> NovemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='November'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
        ));
      }


    }
    return columnContent;
  }
  List<Widget> DecemberList() {
    List<Widget> columnContent = [];
    for (int index = 0; index < planList.length; index++) {
      if(planList[index].monthOfYear=='December'){
        columnContent.add(Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          closeOnScroll: true,
          actions: <Widget>[
            IconSlideAction(
              color: Colors.red,
              icon: Icons.delete,
              caption: "Delete",
              closeOnTap: true,
              onTap: (){
                Network_Operations.DeleteCustomerPlan(context,planList[index].recordId).then((response){
                  if(response!=null){
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) =>
                        _refreshIndicatorKey.currentState
                            .show());
                    Flushbar(
                      message: "Production Plan Deleted",
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      message: "Production Plan not Deleted",
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                });
              },
            ),
            IconSlideAction(
              color: Colors.blue,
              icon: Icons.edit,
              caption: "Update",
              closeOnTap: true,
              onTap: (){
                push(context, MaterialPageRoute(builder: (context)=>UpdateProductionPlan(planList[index])));
              },
            ),
          ],
          child: ListTile(
            title: Text(planList[index].itemSize != null
                ? planList[index].itemSize
                : ''),
            subtitle: Text(
                planList[index].estimatedQuantity != null ? "Quantity:" +
                    planList[index].estimatedQuantity.toString() : ''),
            trailing: Text(planList[index].whichYear != null &&
                planList[index].monthOfYear != null
                ? planList[index].monthOfYear + ' ' +
                planList[index].whichYear.toString()
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
                  builder: (context) => PlanDetail(planList[index],customerId)));
            },
          ),
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
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) =>
                            _refreshIndicatorKey.currentState
                                .show());
                      }else{
                        Network_Operations.GetCustomerPlanBySize(context,customerId, currentSelectedValue, year).then((plans){
                          if(plans!=null&&plans.length>0){
                            setState(() {
                              if(planList!=null){
                                planList.clear();
                              }
                              planList=plans;
                              janSum=0;febSum=0;marSum=0;aprSum=0;maySum=0;juneSum=0;julSum=0;augSum=0;sepSum=0;octSum=0;novSum=0;decSum=0;yearSum=0;

                              for (int index = 0; index < planList.length; index++) {
                                yearSum=yearSum+planList[index].estimatedQuantity;
                                if (planList[index].monthOfYear == 'January') {
                                  janSum = janSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'Febuary') {
                                  febSum = febSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'March') {
                                  marSum = marSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'April') {
                                  aprSum = aprSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'May') {
                                  maySum = maySum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'June') {
                                  juneSum = juneSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'July') {
                                  julSum = julSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'August') {
                                  augSum = augSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'September') {
                                  sepSum = sepSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'October') {
                                  octSum = octSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'November') {
                                  novSum = novSum + planList[index].estimatedQuantity;
                                }else if (planList[index].monthOfYear == 'December') {
                                  decSum = decSum + planList[index].estimatedQuantity;
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