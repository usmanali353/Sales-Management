import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Model/CustomerCases.dart';
import 'package:acmc_customer/Utils.dart';

import '../Network_Operations.dart';
class UpdateCases extends StatefulWidget {
  CustomerCases caseData;

  UpdateCases(this.caseData);

  @override
  _UpdateCasesState createState() => _UpdateCasesState(caseData);
}

class _UpdateCasesState extends State<UpdateCases> {
  TextEditingController description;
  var selectedValue,caseType;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  CustomerCases caseData;
  _UpdateCasesState(this.caseData);
@override
  void initState() {
  description=TextEditingController();
  if(caseData.caseDescription!=null){
    setState(() {
      description.text=caseData.caseDescription;
    });
  }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Update Case")),
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
                      decoration: InputDecoration(hintText: "Description",contentPadding: EdgeInsets.all(16),border: InputBorder.none
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
                      initialValue: Utils.getCaseType(caseData.categoryTypeId),
                      items: ['Inquiry','Complaint'].map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16)
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
                      onSaved: (value){
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
                            _fbKey.currentState.save();
                            Network_Operations.UpdateCustomerCase(context,caseData.caseNum,caseData.customerAccount, description.text, 1, caseType, caseData.customerName, 0, 'caseMemo').then((response){
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Case Updated Sucessfully"),
                                ));
                                Navigator.pop(context,'Refresh');
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Case not Updated"),
                                ));
                              }
                            });
                          }
                        },
                        color: Color(0xFF004c4c),
                        child: Text("Update Case",style: TextStyle(color: Colors.white),),
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
