import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/CreateProductionRequest.dart';
import 'package:salesmanagement/Production_Request/RequestDetails.dart';
import 'package:salesmanagement/Production_Request/UpdateProductionRequest.dart';

class RequestList extends StatefulWidget {
  var requests,type,customerId,size,itemNumber;

  RequestList(this.type,this.customerId,this.size,this.itemNumber);

  @override
  State<StatefulWidget> createState() {
    return _RequestsList(type,customerId,size,itemNumber);
  }
}
class _RequestsList extends ResumableState<RequestList>{
  var requests,temp=['',''],type,customerId,size,itemNumber,isVisible=false,itemSizes,selectedValue;
  _RequestsList(this.type,this.customerId,this.size,this.itemNumber);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color(0xFF004c4c),
        onPressed: (){
          push(context, MaterialPageRoute(builder: (context)=>CreateProductionRequest()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text("Production Requests"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (choice){
                if(choice=='Filter by Size'){
                 Network_Operations.GetItemSizes().then((value){
                   if(value!=null){
                     setState(() {
                       var size=jsonDecode(value);
                       List<String> sizeNames=[];
                       if(size!=null&&size.length>0){
                         sizeNames.insert(0, 'All');
                         for(int i=1;i<size.length;i++){
                           sizeNames.add(size[i]['ItemSize']);
                         }
                         showSizeAlertDialog(context, sizeNames);
                       }
                     });
                   }
                 });
                }else if(choice=='Filter by Item') {
                    Network_Operations.GetOnhandStock("LC0001").then((value) {
                      if (value != null) {
                        setState(() {
                          var items = jsonDecode(value);
                          List<String> itemNames = [];
                          if (items != null && items.length > 0) {
                            itemNames.insert(0, 'All');
                            for (int i = 1; i < items.length; i++) {
                              itemNames.add(items[i]['ItemDescription']);
                            }

                            showAlertDialog(context, itemNames, items);
                          }
                        });
                      }
                    });
                  }
              },
              itemBuilder: (BuildContext context){
                return ['Filter by Size','Filter by Item'].map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
      ),
      body:
        RefreshIndicator(
          onRefresh: (){
            if(type=='All'){
              return Network_Operations.GetProdRequestList(customerId, 1, 100).then((response){
                if(response!=null&&response!=''&&response!='[]'){
                  setState(() {
                    requests.clear();
                    this.requests=jsonDecode(response);
                    this.isVisible=true;
                  });
                }
              });
            }else if(type=='Size'){
              return Network_Operations.GetProdRequestListBySize(customerId, size, 1, 10).then((response){
                if(response!=null&&response!=''&&response!='[]'){
                  setState(() {
                    this.requests=jsonDecode(response);
                  });
                }
              });
            }else
              return Network_Operations.GetProdRequestListByItem(customerId, itemNumber, 1, 10).then((response){
                if(response!=null&&response!=''&&response!='[]'){
                  setState(() {
                    this.requests=jsonDecode(response);
                  });
                }
              });
          },
          key: _refreshIndicatorKey,
          child: Visibility(
            visible: isVisible,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: ListView.builder(itemCount: requests!=null?requests.length:temp.length,itemBuilder: (context,int index){
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
                              Network_Operations.DeleteProdRequest(requests[index]['ProductionRequestId']).then((response){
                                if(response!=null&&response!=''&&response!='[]'){
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) =>
                                      _refreshIndicatorKey.currentState
                                          .show());
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Request Deleted"),
                                  ));
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Request not Deleted"),
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
                               push(context, MaterialPageRoute(builder: (context)=>UpdateProductionRequest(requests[index])));
                            },
                          ),
                        ],
                        child: ListTile(
                          title: Text(requests[index]['ItemDescription']),
                          subtitle: Text((() {
                            if(!requests[index]['PlannedDate'].contains("-22089564")){
                              return 'Quantity:'+requests[index]['QuantityRequested'].toString()+'\n'+'Production Date:'+DateTime.fromMillisecondsSinceEpoch(int.parse(requests[index]['PlannedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]+'\n'+'Status: '+requests[index]['ProductionStatus'];
                            }else
                            return 'Quantity:'+requests[index]['QuantityRequested'].toString()+'\n'+'Status: '+requests[index]['ProductionStatus'];
                          })()),
                          leading:  Material(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.teal.shade100,
                  child: Padding(
                  padding: const EdgeInsets.only(top:10,bottom: 15,right: 10,left: 10),
                  child: Icon(FontAwesomeIcons.industry,size: 30,color: Color(0xFF004c4c),),
                  )
                  ),
                          onTap: (){
                            push(context,MaterialPageRoute(builder: (context)=>RequestDetails(requests[index])));
                          },
                        ),
                      ),
                      Divider(),
                    ],
                  ) ;
                }),
              ),
            ),
          ),
        ),
      );
  }
  showAlertDialog(BuildContext context,List<String> itemsNames,var items) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Network_Operations.GetProdRequestListByItem("LC0001",items[selectedValue]['ItemNumber'], 1, 100).then((value){
          if(value!=null){
            setState(() {
              var requestsByItem=jsonDecode(value);
              if (selectedValue == 0) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) =>
                    _refreshIndicatorKey.currentState
                        .show());
              }else if(requestsByItem!=null&&requestsByItem.length>0) {
                requests.clear();
                requests.addAll(requestsByItem);
                Navigator.pop(context);
              }else{
                Flushbar(
                  message:  "No Requests Found",
                  backgroundColor: Colors.red,
                  duration:  Duration(seconds: 5),
                )..show(context);
                Navigator.pop(context);
              }
            });
          }
        });

      },
    );
    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content:FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormBuilderDropdown(
                  attribute: "Select Item",
                  hint: Text("Select Item"),
                  isDense: true,
                  items: itemsNames!=null?itemsNames.map((plans)=>DropdownMenuItem(
                    child: Text(plans),
                    value: plans,
                  )).toList():[""].map((name) => DropdownMenuItem(
                      value: name, child: Text("$name")))
                      .toList(),
                  onChanged: (value){
                    setState(() {
                      this.selectedValue=itemsNames.indexOf(value);
                    });
                  },
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                  ),

                ),
              ],
            )
          ),
      actions: [
        cancelButton,
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
  showSizeAlertDialog(BuildContext context,List<String> sizeNames) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Network_Operations.GetProdRequestListBySize("LC0001",sizeNames[selectedValue], 1, 100).then((value){
          if(value!=null){
            setState(() {
              var requestsByItem=jsonDecode(value);
              if (selectedValue == 0) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) =>
                    _refreshIndicatorKey.currentState
                        .show());
              }else if(requestsByItem!=null&&requestsByItem.length>0) {
                requests.clear();
                requests.addAll(requestsByItem);
                Navigator.pop(context);
              }else{
                Navigator.pop(context);
                Flushbar(
                  message:  "No Requests Found",
                  backgroundColor: Colors.red,
                  duration:  Duration(seconds: 5),
                )..show(context);
              }
            });
          }
        });

      },
    );
    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content:FormBuilder(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormBuilderDropdown(
                attribute: "Select Item Size",
                hint: Text("Select Item Size"),
                isDense: true,
                items: sizeNames!=null?sizeNames.map((plans)=>DropdownMenuItem(
                  child: Text(plans),
                  value: plans,
                )).toList():[""].map((name) => DropdownMenuItem(
                    value: name, child: Text("$name")))
                    .toList(),
                onChanged: (value){
                  setState(() {
                    this.selectedValue=sizeNames.indexOf(value);
                  });
                },
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                ),

              ),
            ],
          )
      ),
      actions: [
        cancelButton,
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