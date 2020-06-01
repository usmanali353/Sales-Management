import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/PrePicking/PrePickingDetails.dart';

import 'PrePickingLineDetails.dart';
class OrderedProducts extends StatefulWidget {
 var  prePickingData;

 OrderedProducts(this.prePickingData);

 @override
  _OrderedProductsState createState() => _OrderedProductsState(prePickingData);
}

class _OrderedProductsState extends State<OrderedProducts> {
  var prePickingData;

  _OrderedProductsState(this.prePickingData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ordered Products"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView.builder(itemCount:prePickingData['PrePickingLines']!=null?prePickingData['PrePickingLines'].length:0,itemBuilder: (BuildContext context,int index){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(prePickingData['PrePickingLines'][index]['ItemNumber']),
                  subtitle: Text('Quantity: '+prePickingData['PrePickingLines'][index]['SalesQuantity'].toString()),
                  leading:  Material(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.teal.shade100,
                      child: Padding(
                        padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                        child: Icon(FontAwesomeIcons.boxes,size: 30,color: Color(0xFF004c4c),),
                      )
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PickingLinesDetails(prePickingData['PrePickingLines'][index])));
                  },
                ),
                Divider()
              ],
            );
          }),
        ),
      )
      );
  }
}
