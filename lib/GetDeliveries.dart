import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:salesmanagement/DeliveriesList.dart';

class GetDeliveries extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetDeliveries();
  }

}
class _GetDeliveries extends State<GetDeliveries>{
  var selected_date;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Get Deliveries"),),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])     ),
        child: ListView(
          children: <Widget>[
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: FormBuilderDateTimePicker(
                      attribute: "date",
                      style: Theme.of(context).textTheme.body1,
                      inputType: InputType.date,
                      validators: [FormBuilderValidators.required()],
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(labelText: "Select Date", fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                            borderSide: BorderSide(color: Colors.black, width: 9.0)
                        ),),
                      onChanged: (value){
                        this.selected_date=value.year.toString()+"-"+value.month.toString()+"-"+value.day.toString();
                      },
                    ),
                  ),
                  Builder(
                      builder: (context){
                        return Center(
                          child: MaterialButton(
                            onPressed: (){
                              if(_fbKey.currentState.validate()) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        DeliveryList(selected_date)));
                              }
                            },
                            color: Colors.teal,
                            child: Text("Track",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        );
                      }
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