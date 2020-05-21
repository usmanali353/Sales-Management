import'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:salesmanagement/PrePicking/AddProducts.dart';
class AddPrePicking extends StatefulWidget {
  @override
  _AddPrePickingState createState() => _AddPrePickingState();
}

class _AddPrePickingState extends ResumableState<AddPrePicking> {
 final GlobalKey<FormBuilderState> _fbKey=GlobalKey();
 DateTime deliveryDate=DateTime.now();
 TextEditingController driverName,truckNumber,address,mobileNo;

 @override
 void onResume() {
   print("Data "+resume.data.toString());
   if(resume.data.toString()=='Close') {
     Navigator.pop(context,'Refresh');
   }
 }

 @override
  void initState() {
   driverName=TextEditingController();
   truckNumber=TextEditingController();
   address=TextEditingController();
   mobileNo=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add PrePicking"),),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                  child: FormBuilderTextField(
                    controller: address,
                    attribute: "Address",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: mobileNo,
                    attribute: "Mobile No",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Mobile No",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                  child:FormBuilderDateTimePicker(
                    attribute: "date",
                    style: Theme.of(context).textTheme.body1,
                    inputType: InputType.date,
                    validators: [FormBuilderValidators.required()],
                    format: DateFormat("MM-dd-yyyy"),
                    decoration: InputDecoration(labelText: "Delivery Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),),
                    onChanged: (value){
                      setState(() {
                        this.deliveryDate=value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: driverName,
                    attribute: "Driver Name",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Driver Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16, right: 16),
                  child: FormBuilderTextField(
                    controller: truckNumber,
                    attribute: "Truck Number",
                    keyboardType: TextInputType.number,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Truck Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: MaterialButton(
                      color: Colors.teal[800],
                      child: Text("Add Products"),
                      onPressed: (){
                        if(_fbKey.currentState.validate()) {
                          push(context, MaterialPageRoute(builder: (context) => AddProducts(deliveryDate, driverName.text, truckNumber.text,address.text,mobileNo.text)));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
