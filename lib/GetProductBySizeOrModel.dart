import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/ProductDetails.dart';
import 'package:salesmanagement/ProductsList.dart';

class GetProductBySizeOrModel extends StatefulWidget{
 var sizeOrModel;

 GetProductBySizeOrModel(this.sizeOrModel);

 @override
  State<StatefulWidget> createState() {
    return _GetProductBySizeOrModel(sizeOrModel);
  }

}
class _GetProductBySizeOrModel extends State<GetProductBySizeOrModel>{
  var sizeOrModel,selectedValue;
  TextEditingController customerId;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _GetProductBySizeOrModel(this.sizeOrModel);
 @override
  void initState() {
     this.customerId=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Products"),),
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
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderDropdown(
                    attribute: "Select Size or Model",
                    validators: [FormBuilderValidators.required()],
                    hint: Text(sizeOrModel?"Select Size":"Select Model"),
                    items: sizeOrModel?['600x600','450x450'].map((trainer)=>DropdownMenuItem(
                      child: Text(trainer),
                      value: trainer,
                    )).toList():['Alma','Decor'].map((name) => DropdownMenuItem(
                        value: name, child: Text("$name")))
                        .toList(),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: sizeOrModel?"Select Size":"Select Model",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    onChanged: (value){
                      setState(() {
                           this.selectedValue=value;
                      });
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: MaterialButton(
                      color: Colors.teal,
                      child: Text("Search Product"),
                      onPressed: (){
                        if(_fbKey.currentState.validate()){
                          if(sizeOrModel){
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                           Network_Operations.GetProductsBySize(customerId.text, selectedValue,'ItemSize', 1, 10).then((response){
                             pd.dismiss();
                             if(response!=null){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsList(json.decode(response))));
                             }
                           });
                          }else{
                            ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                            pd.show();
                            Network_Operations.GetProductsByModel(customerId.text, selectedValue,'ItemSize', 1, 10).then((response){
                              pd.dismiss();
                              if(response!=null){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsList(jsonDecode(response))));
                              }
                            });
                          }
                        }
                      },
                    ),
                  ),
                )
            ]
          ),
          )
      ],
            ),
          );

  }

}