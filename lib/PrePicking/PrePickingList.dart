import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddPrePicking.dart';
import 'package:salesmanagement/PrePicking/UpdatePrePicking.dart';
import 'file:///G:/Projects/sales_management/sales_management/lib/PrePicking/PrePickingDetails.dart';

import '../Utils.dart';
class PrePickingList extends StatefulWidget {
  @override
  _PrePickingListState createState() => _PrePickingListState();
}

class _PrePickingListState extends ResumableState<PrePickingList> {
  var prePicking,isVisible=false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
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
      appBar: AppBar(
        title: Text("PrePicking"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrePicking()));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
             if(connected){
               ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
               pd.show();
               try{
                 Network_Operations.GetAllPrePicking("LC0001").then((response){
                   pd.dismiss();
                   if(response!=null){
                     setState(() {
                       this.prePicking=jsonDecode(response);
                       this.isVisible=true;
                     });
                   }
                 });
               }catch(e){
                pd.dismiss();
               }
             }
          });
        },
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount:prePicking!=null?prePicking.length:0,itemBuilder: (BuildContext context,int index){
            return Column(
              children: <Widget>[
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
                        Network_Operations.DeletePrePicking(prePicking[index]['PickingId']).then((response){
                          if(response!=null&&response!=''&&response!='[]'){
                            WidgetsBinding.instance
                                .addPostFrameCallback((_) =>
                                _refreshIndicatorKey.currentState
                                    .show());
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("PrePicking Deleted"),
                            ));
                          }else{
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("PrePicking not Deleted"),
                            ));
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
                        push(context, MaterialPageRoute(builder: (context)=>UpdatePrePicking(prePicking[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                    title: Text(prePicking!=null?prePicking[index]['PickingId']:''),
                    subtitle: Text(prePicking!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(prePicking[index]['DeliveryDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                    trailing: Text(prePicking!=null?getStatus(prePicking[index]['Status']):''),
                    leading: Icon(FontAwesomeIcons.truckLoading),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrePickingDetails(prePicking[index])));
                    },
                  ),
                ),
                Divider(),
              ],
            );
          }),
        ),
      ),
    );
  }
  String getStatus(int status){
    String statusstr;
    if(status==0){
      statusstr="New Request";
    }else if(status==1){
      statusstr="Submitted";
    }else if(status==2){
      statusstr="Approved";
    }else if(status==3){
      statusstr="Rejected";
    }else {
      statusstr="Generate Picking List";
    }
    return statusstr;
  }
}
