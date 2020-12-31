import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:acmc_customer/Model/ItemSizes.dart';
import 'package:acmc_customer/Model/Products.dart';
import 'package:acmc_customer/Model/sqlite_helper.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/PrePicking/AddPrePicking.dart';
import 'package:acmc_customer/Production_Request/CreateProductionRequest.dart';
import 'package:acmc_customer/Production_Request/RequestDetails.dart';
import 'package:acmc_customer/Production_Request/UpdateProductionRequest.dart';

import '../Utils.dart';

class RequestList extends StatefulWidget {
  var size,month,customerId;

  RequestList(this.size,this.month,this.customerId,);

  @override
  State<StatefulWidget> createState() {
    return _RequestsList(size,month,customerId);
  }
}
class _RequestsList extends ResumableState<RequestList>{
  var requests,temp=['',''],isVisible=false,itemSizes,selectedValue,size,month,customerId,itemStock;
  _RequestsList(this.size,this.month,this.customerId,);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<FormBuilderState> _fbKey=GlobalKey();
  TextEditingController quantity;
  sqlite_helper db;
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
    quantity=TextEditingController();
    db=sqlite_helper();
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
          push(context, MaterialPageRoute(builder: (context)=>CreateProductionRequest(customerId,null)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text("Production Requests"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (choice){
                if(choice=='Filter by Size'){
                  Utils.check_connectivity().then((connected){
                    if(connected){
                      Network_Operations.GetItemSizes(context).then((value){
                        if(value!=null){
                          setState(() {
                            List<ItemSizes> size=value;
                            List<String> sizeNames=[];
                            if(size!=null&&size.length>0){
                              sizeNames.insert(0, 'All');
                              for(int i=1;i<size.length;i++){
                                sizeNames.add(size[i].itemSize);
                              }
                              showSizeAlertDialog(context, sizeNames);
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

                }else if(choice=='Filter by Item') {
                  Utils.check_connectivity().then((connected){
                    if(connected){
                      Network_Operations.GetOnhandStock(context,customerId).then((value) {

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
                    }else{
                      Flushbar(
                        message: "Network not Available",
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                      )..show(context);
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
              return Utils.check_connectivity().then((connected){
                if(connected){
                  if(size!=null&&month!=null){
                    Network_Operations.GetProdRequestListBySize(context,customerId,size, 1, 100).then((response){
                      if(response!=null&&response!=''&&response!='[]'){
                        setState(() {
                          var filteredRequest=[];
                          if(requests!=null){
                            requests.clear();
                          }
                          this.requests=jsonDecode(response);
                          if(requests!=null&&requests.length>0){
                            for(int i=0;i<requests.length;i++){
                              if(requests[i]['ProductionMonth']==month){
                                filteredRequest.add(requests[i]);
                              }
                            }
                            if(filteredRequest!=null&&filteredRequest.length>0){
                              requests.clear();
                              requests.addAll(filteredRequest);
                              this.isVisible=true;
                            }else{
                              Flushbar(
                                message: "No Requests Found",
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 5),
                              )..show(context);
                            }

                          } else{

                          }

                        });
                      }
                    });
                  }else{
                    Network_Operations.GetProdRequestList(context,customerId, 1, 100).then((response){
                      if(response!=null&&response!=''&&response!='[]'){
                        setState(() {
                          if(requests!=null){
                            requests.clear();
                          }
                          this.requests=jsonDecode(response);
                          this.isVisible=true;
                        });
                      }
                    });
                  }

                }else{
                  Flushbar(
                    message: "Network not Available",
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  )..show(context);
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
                              Network_Operations.DeleteProdRequest(context,requests[index]['ProductionRequestId']).then((response){
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
                          isThreeLine: true,
                          subtitle: Text((() {
                            if(!requests[index]['PlannedDate'].contains("-22089564")){
                              return 'Request Date: '+DateTime.fromMillisecondsSinceEpoch(int.parse(requests[index]['RequestedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]+'\n'+'Quantity:'+requests[index]['QuantityRequested'].toString()+'\n'+'Production Date:'+DateTime.fromMillisecondsSinceEpoch(int.parse(requests[index]['PlannedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]+'\n'+'Status: '+requests[index]['ProductionStatus'];
                            }else
                            return 'Request Date: '+DateTime.fromMillisecondsSinceEpoch(int.parse(requests[index]['RequestedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]+'\n'+'Quantity:'+requests[index]['QuantityRequested'].toString()+'\n'+'Status: '+requests[index]['ProductionStatus'];
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
                            if(requests[index]['ProductionStatus']=='Produced'){
                              Network_Operations.GetOnhandStock(context,customerId).then((response){
                                if(response!=null){
                                  setState(() {
                                    var items=jsonDecode(response);
                                  if(items!=null&&items.length>0){
                                    itemStock=0;
                                    for(int i=0;i<items.length;i++){
                                       if(items[i]['ItemDescription']==requests[index]['ItemDescription']){
                                         this.itemStock=items[i]['OnhandALL'];
                                         showOrderAlertDialog( context,requests[index],itemStock);
                                       }
                                    }
                                  }


                                  });

                                }
                              });

                            }else {
                              push(context,MaterialPageRoute(builder: (context)=>RequestDetails(requests[index])));
                            }
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
        Network_Operations.GetProdRequestListByItem(context,customerId,items[selectedValue]['ItemNumber'], 1, 100).then((value){
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
      title: Text("Filter by Item"),
      content:FormBuilder(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FormBuilderDropdown(
                  attribute: "Select Item",
                  hint: Text("Select Item"),
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
                  style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 11)),
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
  Widget typeFieldWidget(List<String> sizeNames) {
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
                      selectedValue = newValue;
                      Navigator.pop(context);
                      Network_Operations.GetProdRequestListBySize(context,customerId,selectedValue, 1, 100).then((value){
                        if(value!=null){
                          setState(() {
                            var requestsByItem=jsonDecode(value);
                            if (selectedValue == 'All') {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) =>
                                  _refreshIndicatorKey.currentState
                                      .show());
                            }else if(requestsByItem!=null&&requestsByItem.length>0) {
                              requests.clear();
                              requests.addAll(requestsByItem);
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
                    });
                  },
                  items: sizeNames.map((String value) {
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
  showSizeAlertDialog(BuildContext context,List<String> sizeNames) {
    // set up the buttons
    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Filter by Size"),
      content:typeFieldWidget(sizeNames),
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
  showOrderAlertDialog(BuildContext context,var request,var quantity) {
   var producedAmount=request['QuantityProduced'];
    // set up the buttons
    Widget remindButton = FlatButton(
      child: Text("Order"),
      onPressed:  () {
       Navigator.pop(context);
       showQuantityAlertDialog(context,producedAmount,request);
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Request Details"),
      onPressed:  () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestDetails(request)));
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
      title: Text(request['ItemDescription']),
      content: RichText(
        text: TextSpan(
            children: [
              TextSpan(text: "You have ",style: Theme.of(context).textTheme.bodyText1),
              TextSpan(text: "$quantity",style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.teal))),
              TextSpan(text: " SQM available for this item and Produced ",style: Theme.of(context).textTheme.bodyText1),
              TextSpan(text: "$producedAmount",style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.teal))),
            ]
        ),
      ), //Text("You have $selectedItemStock SQM available for this item"),
      actions: [
        remindButton,
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
  showQuantityAlertDialog(BuildContext context,var producedQuantity,var request) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Add"),
      onPressed:  () {
        if(_fbKey.currentState.validate()) {
           if(int.parse(quantity.text)>producedQuantity){
             Flushbar(
               message: "Order Quantity should be less then Produced Quantity",
               backgroundColor: Colors.red,
               duration: Duration(seconds: 5),
             )..show(context);
           }else{
              Products p=Products(request['ItemDescription'],request['ItemNumber'],request['ItemSize'],null,null,null,null,double.parse(quantity.text));
              db.addProducts(p).then((value){
                if(value>0){
                  Navigator.pop(context);
                  push(context, MaterialPageRoute(builder: (context)=>AddPrePicking(customerId)));
                }
              });
           }
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Quantity"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              attribute: 'Quantity',
              controller: quantity,
              keyboardType: TextInputType.numberWithOptions(),
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Quantity to Order",
              ),
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
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