import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../Network_Operations.dart';
class CreateProductionPlan extends StatefulWidget {
  @override
  _CreateProductionPlanState createState() => _CreateProductionPlanState();
}

class _CreateProductionPlanState extends State<CreateProductionPlan> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId,quantity;
  var itemSizesJson,selectedValue,selectedYear,selectedMonth,isVisible=false;
  List<String> itemSizes=[],months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'];
  @override
  void initState() {
    customerId=TextEditingController();
    quantity=TextEditingController();
    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
    pd.show();
    Network_Operations.GetItemSizes().then((response){
      pd.dismiss();
      if(response!=null){
        setState(() {
          itemSizesJson=json.decode(response);
          for(int i=0;i<itemSizesJson.length;i++){
            itemSizes.add(itemSizesJson[i]['ItemSize']);
            isVisible=true;
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Production Plan"),),
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
                    child: FormBuilderDropdown(
                      attribute: "Select ItemSize",
                      hint: Text("Select Item Size"),
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
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(labelText: "Select Item Size",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
                        ),
                      ),

                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderDropdown(
                    attribute: "Select Year",
                    validators: [FormBuilderValidators.required()],
                    hint: Text("Select Year"),
                    items: ['2020','2021','2022','2023','2024','2025'].map((trainer)=>DropdownMenuItem(
                      child: Text(trainer),
                      value: trainer,
                    )).toList(),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Select Year",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    onChanged: (value){
                      setState(() {
                        this.selectedYear=value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderDropdown(
                    attribute: "Select Month",
                    hint: Text("Select Month"),
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
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Select Month",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child:  FormBuilderTextField(
                    controller: quantity,
                    attribute: "Quantity",
                    keyboardType: TextInputType.number,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Quantity",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: const EdgeInsets.only(top:16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            Network_Operations.CreateCustomerPlan('LC0001', selectedValue, selectedMonth, int.parse(selectedYear),int.parse(quantity.text)).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Customer Plan Created Sucessfully"),
                                ));
                                Navigator.pop(context,'Refresh');
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Customer Plan not Created"),
                                ));
                              }
                            });
                          }
                        },
                        child: Text("Add Production Plan",style: TextStyle(color: Colors.white),),
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
