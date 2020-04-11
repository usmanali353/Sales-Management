import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Sales_Services/Products/GetProductBySizeOrModel.dart';
import 'ProductDetails.dart';

class GetProductInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _GetProductInfo();
  }

}
class _GetProductInfo extends State<GetProductInfo>{
  TextEditingController itemNumber;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    itemNumber=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("View Product Info"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='View Product Info by Size'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductBySizeOrModel(true)));
              }else if(choice=='View Product Info by Model'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductBySizeOrModel(false)));
              }
            },
            itemBuilder: (BuildContext context){
              return ['View Product Info by Size','View Product Info by Model'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
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
                MaterialButton(
                  color: Colors.teal,
                  onPressed: (){
                    if(_fbKey.currentState.validate()){
                      ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                      pd.show();
                      Network_Operations.GetProductInfo(itemNumber.text).then((response){
                        pd.dismiss();
                        if(response!=null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(jsonDecode(response))));
                        }
                      });
                    }
                  },
                  child: Text("Get Product Info",style:TextStyle(color: Colors.white),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}