import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Network_Operations.dart';

class UpdateProductionRequest extends StatefulWidget {
  var requestData;

  UpdateProductionRequest(this.requestData);

  @override
  _UpdateProductionRequestState createState() => _UpdateProductionRequestState(requestData);
}

class _UpdateProductionRequestState extends State<UpdateProductionRequest> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerItemCode,quantity;
  var selectedMonth,requestData,isVisible=false,itemNumber;

  _UpdateProductionRequestState(this.requestData);

  List<String> months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'];
  @override
  void initState() {
    customerItemCode=TextEditingController();
    quantity=TextEditingController();
    itemNumber=TextEditingController();
    itemNumber.text=requestData['ItemNumber'];
    customerItemCode.text=requestData['CustomerItemCode'];
    quantity.text=requestData['QuantityRequested'].toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Production Request")),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: itemNumber,
                      readOnly: true,
                      enabled: false,
                      attribute: "Item Number",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Item Number",border: InputBorder.none,contentPadding: EdgeInsets.all(16)
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
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Select Production Month",
                      hint: Text("Select Production Month"),
                      initialValue: requestData['ProductionMonth'],
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

//                      border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(9.0),
//                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                      ),
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
                      decoration: InputDecoration(hintText: "Customer Item Code",
                       contentPadding: EdgeInsets.all(16),border: InputBorder.none
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
                      decoration: InputDecoration(hintText: "Quantity",
                          contentPadding: EdgeInsets.all(16),
                          border: InputBorder.none
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
                        child: Text("Update Production Request",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            _fbKey.currentState.save();
                            Network_Operations.UpdateProductionRequest(context,requestData['CustomerAccount'], itemNumber.text, customerItemCode.text, selectedMonth, int.parse(quantity.text), requestData['RequestedDate'],requestData['CustomerPONum'],requestData['ProductionRequestId']).then((response){
                              if(response!=null){
                                Navigator.pop(context,'Refresh');
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Production Request Updated"),
                                ));
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Production Request not Updated"),
                                ));
                              }
                            });
                          }
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

}
