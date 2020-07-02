import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

class CreateCase extends StatefulWidget{
  var customerId;

  CreateCase(this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _CreateCase(customerId);
  }

}
class _CreateCase extends State<CreateCase>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController description;
  var selectedValue,caseType,customerId;

  _CreateCase(this.customerId);

  @override
  void initState() {
    description=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Case")),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: description,
                      attribute: "description",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Description",
                        contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Case Type",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Case Type"),
                      items: ['Inquiry','Complaint'].map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList(),
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          if(value=='Inquiry'){
                            caseType=5637145326;
                          }else if(value=='Complaint'){
                            caseType=5637144576;
                          }
                        });
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            Network_Operations.CreateCustomerCase(customerId, description.text, 1, caseType, 'some customer', 0, 'caseMemo').then((response){
                              pd.hide();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Case Added Sucessfully"),
                                ));
                                Navigator.pop(context,'Refresh');
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Case not Added"),
                                ));
                              }
                            });
                          }
                        },
                        color:  Color(0xFF004c4c),
                        child: Text("Add Case",style: TextStyle(color: Colors.white),),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}