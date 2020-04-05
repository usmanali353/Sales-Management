import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:salesmanagement/SalesOrdersDetails.dart';

class GetSalesOrders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetSalesOrders();
  }

}
class _GetSalesOrders extends State<GetSalesOrders>{
  var selected_start_date,selected_end_date;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Get Sales Orders"),),
      body:  Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])
        ),
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  FormBuilderDateTimePicker(
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
                  ),
                  Padding(padding: EdgeInsets.all(9)),
                  FormBuilderDateTimePicker(
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
                  Center(heightFactor: 1.75,
                    child: MaterialButton(
                      onPressed: (){
                        if(_fbKey.currentState.validate()) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  SalesOrdersDetails(selected_start_date,
                                      selected_end_date)));
                        }
                      },
                      color: Colors.teal,
                      child: Text("Track",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

}