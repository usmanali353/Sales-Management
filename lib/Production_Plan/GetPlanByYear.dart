import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

import 'GetPlanByMonth.dart';
import 'GetPlanByYearAndSize.dart';

class GetPlanByYear extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _GetPlanByYear();
  }

}
class _GetPlanByYear extends State<GetPlanByYear>{
  var selectedYear;
  TextEditingController customerId;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    customerId=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Production Plan"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Plan By Size and Month'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPlanByMonth()));
              }else if(choice=='Plan By Size and Year'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPlanByYearAndSize()));
              }
            },
            itemBuilder: (BuildContext context){
              return ['Plan By Size and Month','Plan By Size and Year'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
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
                    Builder(
                      builder: (BuildContext context){
                        return  Padding(
                          padding: EdgeInsets.only(top:16),
                          child: MaterialButton(
                            onPressed: (){
                                 if(_fbKey.currentState.validate()){
                                  ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                                  pd.show();
                                  Network_Operations.GetCustomerPlan(customerId.text,selectedYear).then((response){
                                    pd.dismiss();
                                    if(response!=null&&response!=''&&response!='[]'){

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