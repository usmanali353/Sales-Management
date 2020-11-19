import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

class ItemStockDetail extends StatefulWidget{
  var itemNumber;
  ItemStockDetail(this.itemNumber);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemStockDetail(itemNumber);
  }

}
class _ItemStockDetail extends State<ItemStockDetail>{
  var itemNumber,itemStockData,isVisible=false,temp=['',''];
  _ItemStockDetail(this.itemNumber);
  @override
  void initState() {
    Network_Operations.GetOnHandByItem(context,itemNumber).then((response){
       if(response!=null){
         setState(() {
           this.itemStockData=json.decode(response);
           this.isVisible=true;
         });
       }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text("Item Stock Details")),),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
          itemCount: itemStockData!=null?itemStockData.length:temp.length,
            itemBuilder: (context,int index){
             return Column(
             children: <Widget>[
               ListTile(
                 title: Text(itemStockData[index]['ItemDescription']!=null?itemStockData[index]['ItemDescription']:''),
                 subtitle: Text(itemStockData[index]['Grade']!=null?"Grade: "+itemStockData[index]['Grade']:''),
                 leading: Icon(FontAwesomeIcons.boxOpen,size: 30,),
                 trailing: Text(itemStockData[index]['OnHandQty']!=null?itemStockData[index]['OnHandQty'].toString():''),
                 onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemDetail(items[index])));
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