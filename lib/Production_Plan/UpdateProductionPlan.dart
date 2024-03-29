import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Model/ItemSizes.dart';
import 'package:acmc_customer/Model/ProductionPlans.dart';
import '../Network_Operations.dart';

class UpdateProductionPlan extends StatefulWidget {
  ProductionPlans planData;

  UpdateProductionPlan(this.planData);

  @override
  _UpdateProductionPlanState createState() => _UpdateProductionPlanState(planData);
}
class _UpdateProductionPlanState extends State<UpdateProductionPlan> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController quantity;
  var selectedValue,selectedYear,selectedMonth,isVisible=false;
  ProductionPlans planData;
  List<ItemSizes> sizes=[];
  _UpdateProductionPlanState(this.planData);

  List<String> itemSizes=[],months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'],years=['2020','2021','2022','2023','2024','2025'];
  @override
  void initState() {
    quantity=TextEditingController();
    Network_Operations.GetItemSizes(context).then((response){
      if(response!=null){
        setState(() {
          sizes=response;
          for(int i=0;i<sizes.length;i++){
            itemSizes.add(sizes[i].itemSize);
            isVisible=true;
          }
        });
      }
    });
   // customerId.text=planData['CustomerAccount'];
    quantity.text=planData.estimatedQuantity.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Production Plan")),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Visibility(
                    visible: isVisible,
                    child: Card(
                      elevation: 10,
                      child: FormBuilderDropdown(
                        attribute: "Select ItemSize",
                        hint: Text("Select Item Size"),
                        initialValue: planData.itemSize,
                        items: itemSizes!=null?itemSizes.map((plans)=>DropdownMenuItem(
                          child: Text(plans),
                          value: plans,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            this.selectedValue=value;
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            this.selectedValue=value;
                          });
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
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
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Select Year",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Select Year"),
                      initialValue:planData.whichYear.toString(),
                      items: years.map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          this.selectedYear=value;
                        });
                      },
                      onSaved: (value){
                        setState(() {
                          this.selectedYear=value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Select Month",
                      hint: Text("Select Month"),
                      initialValue: planData.monthOfYear,
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
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),

                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
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
                      padding: const EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        color: Color(0xFF004c4c),
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            _fbKey.currentState.save();
                            Network_Operations.UpdateCustomerPlan(context,planData.customerAccount, selectedValue, selectedMonth, int.parse(selectedYear),int.parse(quantity.text),planData.recordId).then((response){
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Customer Plan Updated Sucessfully"),
                                ));
                                Navigator.pop(context,'Refresh');
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Customer Plan not Updated"),
                                ));
                              }
                            });
                          }
                        },
                        child: Text("Update Production Plan",style: TextStyle(color: Colors.white),),
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
