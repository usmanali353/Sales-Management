import 'dart:io';

import 'package:flushbar/flushbar.dart';
import'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddProducts.dart';
class AddPrePicking extends StatefulWidget {
  var customerId;

  AddPrePicking(this.customerId);

  @override
  _AddPrePickingState createState() => _AddPrePickingState(customerId);
}

class _AddPrePickingState extends State<AddPrePicking> {
 final GlobalKey<FormBuilderState> _fbKey=GlobalKey();
 DateTime deliveryDate=DateTime.now();
 var customerId,isDetail;
 sqlite_helper db;
 List<Products> productList=[];
 List<Map> prePickingLines=[];
 _AddPrePickingState(this.customerId);

 TextEditingController driverName,truckNumber,address,mobileNo;



 @override
  void initState() {
   driverName=TextEditingController();
   truckNumber=TextEditingController();
   address=TextEditingController();
   mobileNo=TextEditingController();
   db=sqlite_helper();
   db.getProducts().then((product){
     if(product.length>0){
       setState(() {
         for(int i=0;i<product.length;i++){
           productList.add(Products.fromMap(product[i]));
         }
       });
     }
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delivery Details"),),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.pop(context,'Refresh');
          return false;
        },
        child: ListView(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                    child: Card(
                      elevation: 10,
                      child: FormBuilderTextField(
                        controller: address,
                        attribute: "Address",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(
                          hintText: "Address",
                          contentPadding: EdgeInsets.all(16),
                           border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide:
//                            BorderSide(color: Colors.teal, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Card(
                      elevation: 10,
                      child: FormBuilderTextField(
                        controller: mobileNo,
                        attribute: "Mobile No",
                        keyboardType: TextInputType.phone,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(
                          hintText: "Mobile No",
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide:
//                            BorderSide(color: Colors.teal, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                    child:Card(
                      elevation: 10,
                      child: FormBuilderDateTimePicker(
                        attribute: "date",
                        style: Theme.of(context).textTheme.body1,
                        inputType: InputType.date,
                        validators: [FormBuilderValidators.required()],
                        format: DateFormat("MM-dd-yyyy"),
                        decoration: InputDecoration(hintText: "Delivery Date",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                        ),
                        onChanged: (value){
                          setState(() {
                            this.deliveryDate=value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    child: Card(
                      elevation: 10,
                      child: FormBuilderTextField(
                        controller: driverName,
                        attribute: "Driver Name",
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(
                          hintText: "Driver Name",
                         contentPadding: EdgeInsets.all(16),
                         border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide:
//                            BorderSide(color: Colors.teal, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:16,left: 16, right: 16),
                    child: Card(
                      elevation: 10,
                      child: FormBuilderTextField(
                        controller: truckNumber,
                        attribute: "Truck Number",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(
                          hintText: "Truck Number",
                          contentPadding: EdgeInsets.all(16),
                           border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide:
//                            BorderSide(color: Colors.teal, width: 1.0)),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: MaterialButton(
                        color: Color(0xFF004c4c),
                        child: Text("Place Order",style: TextStyle(color:Colors.white),),
                        onPressed: (){
                          if(_fbKey.currentState.validate()) {
                              for(int i=0;i<productList.length;i++){
                                prePickingLines.add(
                                    {
                                      "SalesQuantity":productList[i].SalesQuantity,
                                      "ColorItem":productList[i].ColorItem,
                                      "Grade":productList[i].Grade,
                                      "ItemNumber":productList[i].ItemNumber,
                                      "PickingId":"",
                                      "InventoryDimension":productList[i].InventoryDimension,
                                      "SizeItem":productList[i].SizeItem
                                    }
                                );
                              }
                              ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                              pd.show();
                              Network_Operations.CreatePrePicking(customerId, address.text, driverName.text, truckNumber.text, '/Date('+deliveryDate.millisecondsSinceEpoch.toString()+'+0300)/', mobileNo.text, prePickingLines).then((value){
                                pd.hide();
                                if(value!=null){
                                  db.deleteProducts().then((deletedProducts){
                                    if(deletedProducts>0){
                                      setState(() {
                                        productList.clear();
                                      });
                                    }
                                  });
                                  Navigator.pop(context,'Refresh');
                                  Flushbar(
                                    message:  "Sales Order Created",
                                    backgroundColor: Colors.green,
                                    duration:  Duration(seconds: 5),
                                  )..show(context);

                                }else{
                                  db.deleteProducts().then((deletedProducts){
                                    if(deletedProducts>0){
                                      setState(() {
                                        productList.clear();
                                      });
                                    }
                                  });
                                  Flushbar(
                                    message:  "Sales Order Not Created",
                                    backgroundColor: Colors.red,
                                    duration:  Duration(seconds: 5),
                                  )..show(context);
                                }

                              });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
