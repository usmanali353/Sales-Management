import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

class CreateCase extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CreateCase();
  }

}
class _CreateCase extends State<CreateCase>{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController description;
  var selectedValue;
  @override
  void initState() {
    description=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Case"),),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
                    controller: description,
                    attribute: "description",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Description",
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
                    attribute: "Priority",
                    validators: [FormBuilderValidators.required()],
                    hint: Text("Priority"),
                    items: ['High','Medium','Low'].map((trainer)=>DropdownMenuItem(
                      child: Text(trainer),
                      value: trainer,
                    )).toList(),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Priority",
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
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                             Network_Operations.CreateCustomerCase('entity', description.text, 1, 000011548, 'Complaint', 1, selectedValue).then((response){
                               pd.dismiss();
                                if(response!=null&&response!=''){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Case Created Sucessfully"),
                                  ));
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Case not Created"),
                                  ));
                                }
                             });
                          }
                        },
                        color: Colors.teal,
                        child: Text("Add Case"),
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