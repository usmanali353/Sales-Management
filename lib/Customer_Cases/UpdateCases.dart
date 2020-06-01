import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../Network_Operations.dart';
class UpdateCases extends StatefulWidget {
  var caseData;

  UpdateCases(this.caseData);

  @override
  _UpdateCasesState createState() => _UpdateCasesState(caseData);
}

class _UpdateCasesState extends State<UpdateCases> {
  TextEditingController description;
  var selectedValue,caseType;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  var caseData;
  _UpdateCasesState(this.caseData);
@override
  void initState() {
  description=TextEditingController();
  if(caseData['CaseDescription']!=null){
    setState(() {
      description.text=caseData['CaseDescription'];
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
                      attribute: "Priority",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Priority"),
                      initialValue: caseData['Priority'],
                      items: ['High','Medium','Low'].map((trainer)=>DropdownMenuItem(
                        child: Text(trainer),
                        value: trainer,
                      )).toList(),
                      style: Theme.of(context).textTheme.body1,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          this.selectedValue=value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Case Type",
                      validators: [FormBuilderValidators.required()],
                      hint: Text("Case Type"),
                      initialValue: getCaseType(caseData['CategoryTypeId']),
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
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            Network_Operations.UpdateCustomerCase(caseData['CaseNum'],'LC0001', description.text, 1, caseType, selectedValue, caseData['CustomerName'], 0, 'caseMemo').then((response){
                              pd.hide();
                              if(response!=null){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Case Updated Sucessfully"),
                                ));
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
  String getCaseType(int CategoryTypeId){
    String type;
    if(CategoryTypeId==5637145326){
      type="Inquiry";
    }
    if(CategoryTypeId==5637144576){
      type="Complaint";
    }
    return type;
  }
}
