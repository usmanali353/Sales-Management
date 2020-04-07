import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
    if(zero=="Finished Stock"){
      setState(() {
        this.title="Finished Stock";
      });
      ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
      pd.show();
      Network_Operations.GetCustomerOnHandNoStock(CustomerId, 1, 10).then((response){
        pd.dismiss();
        if(response!=null){
          setState(() {
            this.items=json.decode(response);
            this.isVisible=true;
          });
        }
      });
    }else if(zero=="Remaining Stock"){
      setState(() {
        this.title="Remaining Stock";
      });
      ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
      pd.show();
      Network_Operations.GetCustomerOnHand(CustomerId, 1, 10).then((response){
        pd.dismiss();
        if(response!=null){
          setState(() {
            this.items=json.decode(response);
            this.isVisible=true;
          });
        }
      });
    }else if(zero=="Old Stock"){
      setState(() {
        this.title="Older Stock";
      });
      ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
      pd.show();
      Network_Operations.GetCustomerOlderStock(CustomerId, 1, 10).then((response){
        pd.dismiss();
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
                 trailing: Text(items[index]['OnHandQty']!=null?items[index]['OnHandQty'].toString():items[index]['QtyAvailablePhysical'].toString()),
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