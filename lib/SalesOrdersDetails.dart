import 'package:flutter/material.dart';

class SalesOrdersDetails extends StatefulWidget{
  var startDate,endDate;

  SalesOrdersDetails(this.startDate, this.endDate);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SalesOrdersDetails(this.startDate, this.endDate);
  }

}
class _SalesOrdersDetails extends State<SalesOrdersDetails>{
  var startDate,endDate;

  _SalesOrdersDetails(this.startDate, this.endDate);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Sales Order Details"),),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])
        ),

      ),
    );
  }

}