import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'SalesOrdersList.dart';

class GetSalesOrders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetSalesOrders();
  }

}
class _GetSalesOrders extends State<GetSalesOrders>{
  var selected_start_date,selected_end_date;
  TextEditingController CustomerId;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
     CustomerId=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Get Sales Orders"),),
      body:  Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
                    controller: CustomerId,
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
                Padding(padding: EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderDateTimePicker(
                    attribute: "date",
                    style: Theme.of(context).textTheme.body1,
                    inputType: InputType.date,
                    validators: [FormBuilderValidators.required()],
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(labelText: "Start Date",fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.black, width: 1.0)
                      ),),
                    onChanged: (value){
                      selected_start_date=value.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                    },
                  ) ,
                ),
                Padding(padding: EdgeInsets.only(top: 16,right: 16,left: 16),
                  child:  FormBuilderDateTimePicker(
                    attribute: "End Date",
                    style: Theme.of(context).textTheme.body1,
                    inputType: InputType.date,
                    validators: [FormBuilderValidators.required()],
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(labelText: "End Date", fillColor: Colors.black,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.black, width: 1.0)
                      ),),
                    onChanged: (value){
                      this.selected_end_date=value.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                    },
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: MaterialButton(
                      onPressed: (){
                        if(_fbKey.currentState.validate()) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  SalesOrdersList(selected_start_date,
                                      selected_end_date,CustomerId.text)));
                        }
                      },
                      color: Colors.teal,
                      child: Text("Track",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

}