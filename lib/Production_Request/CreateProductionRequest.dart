import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddPrePicking.dart';

import '../Utils.dart';

class CreateProductionRequest extends StatefulWidget {
  var customerId,itemName;

  CreateProductionRequest(this.customerId,this.itemName);

  @override
  _CreateProductionRequestState createState() => _CreateProductionRequestState(customerId,itemName);
}

class _CreateProductionRequestState extends State<CreateProductionRequest> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerItemCode,quantity;
  var selectedMonth,onHand,isVisible=false,selectedItemId,selectedItemStock,customerId,monthlyPlanForecast=0,monthlyRequested=0,itemNam,sizeMonthlyForecast=0,sizeMonthlyRequested=0;
  Map<String, Object> params;
  _CreateProductionRequestState(this.customerId,this.itemNam);

  List<String> months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'],itemName=[];
  @override
  void initState() {
    customerItemCode=TextEditingController();
    quantity=TextEditingController();
    Utils.check_connectivity().then((connected){
       if(connected){
         ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
         pd.show();
         Network_Operations.GetOnhandStock(customerId).then((response){
           pd.dismiss();
           if(response!=null&&response!='[]'){
             setState(() {
               isVisible=true;
               this.onHand=jsonDecode(response);
               for(int i=0;i<onHand.length;i++){
                 itemName.add(onHand[i]['ItemDescription']);
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
  @override
  Widget build(BuildContext context) {
     params = ModalRoute.of(context).settings.arguments;
    print(params);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Production Request"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Visibility(
                    visible: isVisible,
                    child: Card(
                      elevation: 10,
                      child: FormBuilderDropdown(
                        attribute: "Select Item",
                        hint: Text("Select Item"),
                        initialValue: itemNam,
                        items: itemName!=null?itemName.map((plans)=>DropdownMenuItem(
                          child: Text(plans),
                          value: plans,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            this.selectedItemId=onHand[itemName.indexOf(value)]['ItemNumber'];
                            this.selectedItemStock=onHand[itemName.indexOf(value)]['OnhandALL'];
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            this.selectedItemId=onHand[itemName.indexOf(value)]['ItemNumber'];
                            this.selectedItemStock=onHand[itemName.indexOf(value)]['OnhandALL'];
                          });
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16)
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
                        ),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Select Production Month",
                      hint: Text("Select Production Month"),
                      initialValue: params!=null&&params['month']!=null?months[months.indexOf(params['month'])]:null,
                      items: months!=null?months.map((plans)=>DropdownMenuItem(
                        child: Text(plans),
                        value: plans,
                      )).toList():[""].map((name) => DropdownMenuItem(
                          value: name, child: Text("$name")))
                          .toList(),
                      onChanged: (value){
                        setState(() {
                          this.selectedMonth=months.indexOf(value)+1;
                        });
                      },
                      onSaved: (value){
                        setState(() {
                          this.selectedMonth=months.indexOf(value)+1;
                        });
                      },
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: customerItemCode,
                      attribute: "Customer Item Code",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Customer Item Code",contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: quantity,
                      attribute: "Quantity",
                      keyboardType: TextInputType.number,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Quantity",contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: const EdgeInsets.only(top:16),
                      child: MaterialButton(
                        color: Colors.teal[800],
                        child: Text("Create Production Request",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          _fbKey.currentState.save();
                          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                          pd.show();
                          Network_Operations.GetCustomerPlanForecast(customerId,2020,selectedMonth).then((value){
                             pd.dismiss();
                             if(value!=null){
                               setState(() {
                                 monthlyPlanForecast=0;
                                 monthlyRequested=0;
                                 sizeMonthlyForecast=0;
                                 sizeMonthlyRequested=0;
                                 var forecast=jsonDecode(value);
                                 if(forecast!=null&&forecast.length>0){
                                   for(int i=0;i<forecast.length;i++){
                                     monthlyPlanForecast+=forecast[i]['QuantityForcasted'];
                                     monthlyRequested+=forecast[i]['QuantityRequested'];
                                     if(forecast['ItemSize']==params['ItemSize']){
                                       sizeMonthlyForecast+=forecast[i]['QuantityForcasted'];
                                       sizeMonthlyRequested+=forecast[i]['QuantityRequested'];
                                     }
                                   }
                                   if(int.parse(quantity.text)+monthlyRequested>monthlyPlanForecast||int.parse(quantity.text)+sizeMonthlyRequested>sizeMonthlyForecast){
                                     Flushbar(
                                       message: "Quantity Requested exceeding your Overall monthly Forecast which is "+monthlyPlanForecast.toString(),
                                       backgroundColor: Colors.red,
                                       duration: Duration(seconds: 5),
                                     )..show(context);
                                   }else{
                                     showAlertDialog(context);
                                   }
                                 }else{
                                   showAlertDialog(context);
                                 }
                               });

                             }
                          });


                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = FlatButton(
      child: Text("Add Production"),
      onPressed:  () {
        if(_fbKey.currentState.validate()){
          var size=params!=null&&params['ItemSize']!=null?params['ItemSize']:'';
          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
          pd.show();
          Network_Operations.CreateProductionRequest(customerId, selectedItemId, customerItemCode.text, selectedMonth, int.parse(quantity.text),size).then((response){
            pd.dismiss();
            if(response!=null){
              Navigator.pop(context,'Refresh');
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text("Production Request added"),
              ));
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Production Request not added"),
              ));
            }
          });
        }
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Place Order"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrePicking(customerId)));
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
      content: RichText(
         text: TextSpan(
           children: [
             TextSpan(text: "You have ",style: Theme.of(context).textTheme.bodyText1),
             TextSpan(text: "$selectedItemStock",style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.teal))),
             TextSpan(text: " SQM available for this item",style: Theme.of(context).textTheme.bodyText1),
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
}
