import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Utils.dart';

import 'SalesLinesDetails.dart';
class SalesLinesItemsList extends StatefulWidget {
  var orderNumber;

  SalesLinesItemsList(this.orderNumber);

  @override
  _SalesLinesItemsListState createState() => _SalesLinesItemsListState(orderNumber);
}

class _SalesLinesItemsListState extends State<SalesLinesItemsList> {
  var orderNumber,salesLinesData,isVisible=false;

  _SalesLinesItemsListState(this.orderNumber);

  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
          Network_Operations.find_orders(context,orderNumber).then((response){
            if(response!=null){
              setState(() {
                this.salesLinesData=jsonDecode(response);
                this.isVisible=true;
              });

            }
          });

      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Lines Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Visibility(
            visible: isVisible,
            child: ListView.builder(itemCount:salesLinesData!=null?salesLinesData['salesLinesField'].length:0,itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(salesLinesData!=null?salesLinesData['salesLinesField'][index]['nameField']:''),
                    subtitle: Text(salesLinesData!=null?'Quantity:'+salesLinesData['salesLinesField'][index]['salesQtySQMField'].toString():''),
                    leading: Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.teal.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                          child: Icon(FontAwesomeIcons.boxes,size: 30,color: Color(0xFF004c4c),),
                        )
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesLinesDetails(salesLinesData['salesLinesField'][index])));
                    },
                  ),
                  Divider(),
                ],
              );
            }),
          ),

        ),
      ),
    );
  }
}
