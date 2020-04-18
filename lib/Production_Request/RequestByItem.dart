import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/RequestList.dart';

class RequestByItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RequestByItem();
  }

}
class _RequestByItem extends State<RequestByItem>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId,itemNumber;
  @override
  void initState() {
    this.customerId=TextEditingController();
    this.itemNumber=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Requests by Item"),),
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
                    controller: itemNumber,
                    attribute: "Item Number",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Item Number",
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
                        child: Text("Find Requests",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                          pd.show();
                          Network_Operations.GetProdRequestListByItem(customerId.text, itemNumber.text, 1, 10).then((response){
                            pd.dismiss();
                             if(response!=null&&response!=''&&response!='[]'){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(jsonDecode(response),'Item',customerId.text,null,itemNumber.text)));
                             }else{
                               Scaffold.of(context).showSnackBar(SnackBar(
                                 backgroundColor: Colors.red,
                                 content: Text("Requests Not Found"),
                               ));
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