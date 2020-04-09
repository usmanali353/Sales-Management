import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'StockItemsDetails.dart';

class StockItemsList extends StatefulWidget{
  var items,title;

  StockItemsList(this.title,this.items);

  @override
  State<StatefulWidget> createState() {
    return _StockItemsList(this.title,this.items);
  }

}
class _StockItemsList extends State<StockItemsList>{
  var items,title,temp=['',''];

  _StockItemsList(this.title,this.items);
@override
  void initState() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(
          itemCount: items!=null?items.length:temp.length,
          itemBuilder: (context,int index){
         return Column(
           children: <Widget>[
             ListTile(
               title: Text(items[index]['ItemDescription']!=null?items[index]['ItemDescription']:''),
               leading: Icon(FontAwesomeIcons.boxOpen,size: 30,),
               trailing: Text(items[index]['OnHandQty']!=null?items[index]['OnHandQty'].toString():items[index]['QtyAvailablePhysical'].toString()),
               onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemDetail(items[index])));
               },
             ),
             Divider(),
           ],
         );
      }),
    );
  }
}