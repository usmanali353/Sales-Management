import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesmanagement/DeliveryDetails.dart';

import 'Network_Operations.dart';

class DeliveryList extends StatefulWidget{
  String date;

  DeliveryList(this.date);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeliveryList(date);
  }

}
class _DeliveryList extends State<DeliveryList>{
  bool isVisible=false;
  var orders_list,temp=['',''];
  String date;

  _DeliveryList(this.date);

  @override
  void initState() {
    Network_Operations.get_deliveries(date).then((response){
      if(response!=null){
        setState(() {
          orders_list=json.decode(response);
          isVisible=true;
        });
      }else{
        setState(() {
          isVisible=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Deliveries'),),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])
        ),
        child: Visibility(
          visible: isVisible,
          child: ListView.builder(itemCount: orders_list!=null?orders_list.length:temp.length,itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(orders_list[index]['salesIdField']),
                  leading: Icon(Icons.local_shipping,size: 30,),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>DeliveryDetails(orders_list[index])));
                  },
                ),
                Divider(),
              ],
            ) ;
          }),
        ),
      ),
    );
  }

}