import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Production_Plan/PlanList.dart';
import '../Network_Operations.dart';

class GetPlanByYearAndSize extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GetPlanByYearAndSize();
  }

}
class _GetPlanByYearAndSize extends State<GetPlanByYearAndSize>{
  var selectedYear,customerId;
  var itemSizesJson,selectedValue,selectedMonth,isVisible=false;
  List<String> itemSizes=[];
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    customerId=TextEditingController();
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
      appBar: AppBar(
        title: Text("View Production Plan"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FormBuilderTextField(
                        controller: customerId,
                        attribute: "Custermer Id",
                        style: Theme.of(context).textTheme.body1,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(labelText: "Customer Id", fillColor: Colors.black,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              borderSide: BorderSide(color: Colors.black, width: 9.0)
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: FormBuilderDropdown(
                        attribute: "Select Year",
                        validators: [FormBuilderValidators.required()],
                        hint: Text("Select Year"),
                        items: ['2019','2020'].map((trainer)=>DropdownMenuItem(
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
                    Builder(
                      builder: (BuildContext context){
                        return  Padding(
                          padding: EdgeInsets.only(top:16),
                          child: MaterialButton(
                            onPressed: (){
                              if(_fbKey.currentState.validate()){
                                ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                pd.show();
                                Network_Operations.GetCustomerPlanBySize(customerId.text,selectedValue,selectedYear).then((response){
                                  pd.dismiss();
                                  if(response!=null&&response!=''&&response!='[]'){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanList(jsonDecode(response),'Size and Year',selectedYear,null,selectedValue,customerId.text)));
                                  }else{
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("Production Plan Not Found"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              }
                            },
                            color: Colors.teal,
                            child: Text("Find Production Plan"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}