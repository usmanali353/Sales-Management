import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Network_Operations.dart';

import 'StockItemsDetails.dart';

class StockItemsList extends StatefulWidget{
  var zero,CustomerId;

  StockItemsList(this.zero,this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StockItemsList(zero,CustomerId);
  }

}
class _StockItemsList extends State<StockItemsList>{
  var zero,CustomerId,items,title,isVisible=false,temp=['',''];

  _StockItemsList(this.zero,this.CustomerId);
@override
  void initState() {
    if(zero){
      setState(() {
        this.title="Finished Stock";
      });
      Network_Operations.GetCustomerOnHandNoStock(CustomerId, 1, 10).then((response){
        if(response!=null){
          setState(() {
            this.items=json.decode(response);
            this.isVisible=true;
          });
        }
      });
    }else{
      setState(() {
        this.title="Remaining Stock";
      });
      Network_Operations.GetCustomerOnHand(CustomerId, 1, 10).then((response){
        if(response!=null){
          setState(() {
            this.items=json.decode(response);
            this.isVisible=true;
          });
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
            itemCount: items!=null?items.length:temp.length,
            itemBuilder: (context,int index){
           return Column(
             children: <Widget>[
               ListTile(
                 title: Text(items[index]['ItemDescription']!=null?items[index]['ItemDescription']:''),
                 leading: Icon(FontAwesomeIcons.boxOpen,size: 30,),
                 trailing: Text(items[index]['OnHandQty']!=null?items[index]['OnHandQty'].toString():''),
                 onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemDetail(items[index])));
                 },
               ),
               Divider(),
             ],
           );
        }),
      ),
    );
  }

}