import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/RequestList.dart';
import 'ProductionScheduleByItem.dart';
import 'ProductionScheduleByRequest.dart';
import 'ScheduleList.dart';

class ViewProductionSchedule extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ViewProductionSchedule();
  }

}
class _ViewProductionSchedule extends State<ViewProductionSchedule>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId;
  @override
  void initState() {
    customerId=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Production Schedule"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='By Request'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductionScheduleByRequest()));
              }else if(choice=='By Item'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductionScheduleByItem()));
              }
            },
            itemBuilder: (BuildContext context){
              return ['By Item','By Request'].map((String choice){
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
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
                    controller: customerId,
                    attribute: "Customer Id",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Customer Id",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return  MaterialButton(
                      color: Colors.teal,
                      onPressed: (){
                        if(_fbKey.currentState.validate()) {
                          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                          pd.show();
                          Network_Operations.GetProductionSchedules(customerId.text, 1, 10).then((response){
                            pd.dismiss();
                            if(response!=null&&response!=''){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulesList(jsonDecode(response))));
                            }
                          });
                        }

                      },
                      child: Text("Find Production Schedule",style:TextStyle(color: Colors.white),),
                    );
                  },
                )

              ],
            ),
          )
        ],
      ),
    );
  }

}