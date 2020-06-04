import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddPrePicking.dart';

class CreateProductionRequest extends StatefulWidget {
  @override
  _CreateProductionRequestState createState() => _CreateProductionRequestState();
}

class _CreateProductionRequestState extends State<CreateProductionRequest> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  TextEditingController customerItemCode,quantity;
  var selectedMonth,onHand,isVisible=false,selectedItemId,selectedItemStock;
  List<String> months=['January','Febuary','March','April','May','June','July','August','September','October','November','December'],itemName=[];
  @override
  void initState() {
    customerItemCode=TextEditingController();
    quantity=TextEditingController();
    Network_Operations.GetOnhandStock('LC0001').then((response){
      if(response!=null&&response!='[]'){
        setState(() {
          isVisible=true;
           this.onHand=jsonDecode(response);
           for(int i=0;i<onHand.length;i++){
             itemName.add(onHand[i]['ItemDescription']);
           }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object> params = ModalRoute.of(context).settings.arguments;
    print(params);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Production Request"),
      ),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Visibility(
                    visible: isVisible,
                    child: Card(
                      elevation: 10,
                      child: FormBuilderDropdown(
                        attribute: "Select Item",
                        hint: Text("Select Item"),
                        initialValue: params!=null&&params['itemName']!=null?itemName[itemName.indexOf(params['itemName'])]:null,
                        items: itemName!=null?itemName.map((plans)=>DropdownMenuItem(
                          child: Text(plans),
                          value: plans,
                        )).toList():[""].map((name) => DropdownMenuItem(
                            value: name, child: Text("$name")))
                            .toList(),
                        onChanged: (value){
                          setState(() {
                            this.selectedItemId=onHand[itemName.indexOf(value)]['ItemNumber'];
                            this.selectedItemStock=onHand[itemName.indexOf(value)]['OnhandALL'];
                          });
                        },
                        onSaved: (value){
                          setState(() {
                            this.selectedItemId=onHand[itemName.indexOf(value)]['ItemNumber'];
                            this.selectedItemStock=onHand[itemName.indexOf(value)]['OnhandALL'];
                          });
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16)
//                          border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(9.0),
//                              borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                          ),
                        ),

                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child: Card(
                    elevation: 10,
                    child: FormBuilderDropdown(
                      attribute: "Select Production Month",
                      hint: Text("Select Production Month"),
                      initialValue: params!=null&&params['month']!=null?months[months.indexOf(params['month'])]:null,
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
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(16),
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: customerItemCode,
                      attribute: "Customer Item Code",
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Customer Item Code",contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16),
                  child:  Card(
                    elevation: 10,
                    child: FormBuilderTextField(
                      controller: quantity,
                      attribute: "Quantity",
                      keyboardType: TextInputType.number,
                      validators: [FormBuilderValidators.required()],
                      decoration: InputDecoration(hintText: "Quantity",contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: const EdgeInsets.only(top:16),
                      child: MaterialButton(
                        color: Colors.teal[800],
                        child: Text("Create Production Request",style: TextStyle(color: Colors.white),),
                        onPressed: (){
                         showAlertDialog(context);
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
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = FlatButton(
      child: Text("Add Production"),
      onPressed:  () {
        if(_fbKey.currentState.validate()){
          ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
          pd.show();
          Network_Operations.CreateProductionRequest('LC0001', selectedItemId, customerItemCode.text, selectedMonth, int.parse(quantity.text)).then((response){
            pd.dismiss();
            if(response!=null){
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.green,
                content: Text("Production Request added"),
              ));
              Navigator.pop(context,'Refresh');
            }else{
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text("Production Request not added"),
              ));
            }
          });
        }
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Place Order"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPrePicking()));
      },
    );
    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: RichText(
         text: TextSpan(
           children: [
             TextSpan(text: "You have ",style: Theme.of(context).textTheme.bodyText1),
             TextSpan(text: "$selectedItemStock",style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.teal))),
             TextSpan(text: " SQM available for this item",style: Theme.of(context).textTheme.bodyText1),
           ]
         ),
      ), //Text("You have $selectedItemStock SQM available for this item"),
      actions: [
        remindButton,
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
