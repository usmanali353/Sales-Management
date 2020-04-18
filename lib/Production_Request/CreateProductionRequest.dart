import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

class CreateProductionRequest extends StatefulWidget {
  @override
  _CreateProductionRequestState createState() => _CreateProductionRequestState();
}

class _CreateProductionRequestState extends State<CreateProductionRequest> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerId,itemNumber,customerItemCode,quantity;
  var selectedMonth;
  List<String> months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'];
  @override
  void initState() {
    customerId=TextEditingController();
    itemNumber=TextEditingController();
    customerItemCode=TextEditingController();
    quantity=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Production Request"),),
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
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: FormBuilderDropdown(
                    attribute: "Select Production Month",
                    hint: Text("Select Production Month"),
                    items: months!=null?months.map((plans)=>DropdownMenuItem(
                      child: Text(plans),
                      value: plans,
                    )).toList():[""].map((name) => DropdownMenuItem(
                        value: name, child: Text("$name")))
                        .toList(),
                    onChanged: (value){
                      setState(() {
                        this.selectedMonth=months.indexOf(value)+1;
                      });
                    },
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Select Production Month",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  FormBuilderTextField(
                    controller: customerItemCode,
                    attribute: "Customer Item Code",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Customer Item Code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  FormBuilderTextField(
                    controller: quantity,
                    attribute: "Quantity",
                    keyboardType: TextInputType.number,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Quantity",
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
                      padding: const EdgeInsets.only(top:16),
                      child: MaterialButton(
                        color: Colors.teal,
                        child: Text("Create Production Request",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                          if(_fbKey.currentState.validate()){
                            ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                            pd.show();
                            Network_Operations.CreateProductionRequest(customerId.text, itemNumber.text, customerItemCode.text, selectedMonth, int.parse(quantity.text)).then((response){
                              pd.dismiss();
                               if(response!=null){
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   backgroundColor: Colors.green,
                                   content: Text("Production Request added"),
                                 ));
                               }else{
                                 Scaffold.of(context).showSnackBar(SnackBar(
                                   backgroundColor: Colors.red,
                                   content: Text("Production Request not added"),
                                 ));
                               }
                            });
                          }
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
