import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/RequestList.dart';

import 'ScheduleList.dart';

class ProductionScheduleByRequest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductionScheduleByRequest();
  }

}
class _ProductionScheduleByRequest extends State<ProductionScheduleByRequest>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId,requestId;
  @override
  void initState() {
    this.customerId=TextEditingController();
    this.requestId=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Schedule by Requests"),),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child:  FormBuilderTextField(
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
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child:  FormBuilderTextField(
                    controller: requestId,
                    attribute: "Request Id",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Request Id",
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
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        color: Colors.teal,
                        child: Text("Find Schedule",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                          pd.show();
                          Network_Operations.GetProductionScheduleByRequest(customerId.text, requestId.text, 1, 10).then((response){
                            pd.dismiss();
                            if(response!=null&&response!=''&&response!='[]'){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulesList(jsonDecode(response))));
                            }
                          });
                        },
                      ),
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