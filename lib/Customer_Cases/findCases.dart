import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/CreateCase.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'casesList.dart';

class FindCases extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FindCases();
  }

}
class _FindCases extends State<FindCases>{
  var caseData,selectedValue;
  TextEditingController query;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    query=TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Cases"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCase()));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Create Case"),
              ),
            ),
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
                  child: FormBuilderDropdown(
                    attribute: "Search by query or description",
                    validators: [FormBuilderValidators.required()],
                    hint: Text("Search by"),
                    items: ['Description','Case Id'].map((trainer)=>DropdownMenuItem(
                      child: Text(trainer),
                      value: trainer,
                    )).toList(),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Search by",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    onChanged: (value){
                      setState(() {
                        this.selectedValue=value;
                        query.text="";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: query,
                    attribute: "description or case id",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: selectedValue=="Description"?"Enter Description e.g Shade":"Enter Case Id",
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
                      padding: const EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if(_fbKey.currentState.validate()) {
                            if(selectedValue=="Description") {
                              ProgressDialog pd = ProgressDialog(
                                  context, isDismissible: true,
                                  type: ProgressDialogType.Normal);
                              pd.show();
                              Network_Operations.FindCustomerCases(query.text).then((
                                  response) {
                                pd.dismiss();
                                if (response !='') {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList(jsonDecode(response))));
                                }
                              });
                            }else{
                              ProgressDialog pd = ProgressDialog(
                                  context, isDismissible: true,
                                  type: ProgressDialogType.Normal);
                              pd.show();
                              Network_Operations.GetCustomerCase(query.text).then((
                                  response) {
                                pd.dismiss();
                                if (response !='') {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>casesList(jsonDecode(response))));
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("No Cases Found"),
                                  ));
                                }
                              });
                            }
                          }
                        },
                        child: Text("Find Cases",style:TextStyle(color: Colors.white),),
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