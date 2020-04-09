import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/RequestList.dart';

class RequestBySize extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RequestBySize();
  }

}
class _RequestBySize extends State<RequestBySize>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId;
  var itemSizesJson,selectedValue,isVisible=false;
  List<String> itemSizes=[];
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
      appBar: AppBar(title: Text("Requests by Size"),),
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
                          print(selectedValue);
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
                    return Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                             Network_Operations.GetProdRequestListBySize(customerId.text, selectedValue, 1, 10).then((response){
                               pd.dismiss();
                               if(response!=null&&response!='[]'){
                                 Navigator.push(context,MaterialPageRoute(builder:(context)=>RequestList(jsonDecode(response))));
                               }else{
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   backgroundColor: Colors.red,
                                   content: Text("Requests Not Found"),
                                 ));
                               }
                             });
                          }
                        },
                        child: Text("Find Production Request by Size",style: TextStyle(color: Colors.white),),
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