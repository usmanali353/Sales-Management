import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';

class SearchedOrderDetail extends StatefulWidget{
  String query;
  SearchedOrderDetail(this.query);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchedOrderDetail(query);
  }

}
class _SearchedOrderDetail extends State<SearchedOrderDetail>{
  String query;
  var orders_data;
  bool TableVisible=false;
  _SearchedOrderDetail(this.query);
  @override
  void initState() {
ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
pd.show();
   Network_Operations.find_orders(query).then((response){
     pd.dismiss();
     if(response!=null){
       setState(() {
         this.orders_data=json.decode(response);
         this.TableVisible=true;
       });

     }

   });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(title: (Text("Details")),),
     body: Visibility(
       visible: TableVisible,
       child: SingleChildScrollView(
         child: Column(
           children: <Widget>[
             ListTile(
               title: Text("Customer Name"),
               trailing: Text(orders_data['salesNameField']),
             ),
             Divider(),
             ListTile(
               title: Text("Order id"),
               trailing: Text(orders_data['salesIdField']),
             ),
             Divider(),
             ListTile(
               title: Text("Delivery Date"),
               trailing: Text(orders_data['deliveryDateField']),
             ),
             Divider(),
             ListTile(
               title: Text("Delivery Name"),
               trailing: Text(orders_data['deliveryNameField']),
             ),
             Divider(),
             ListTile(
               title: Text("Truck Number"),
               trailing: Text(orders_data['truckPlateField']),
             ),
             Divider(),
             ListTile(
               title: Text("Start Load"),
               trailing: Text(orders_data['startLoadField']),
             ),
             Divider(),
             ListTile(
               title: Text("Stop Load"),
               trailing: Text(orders_data['stopLoadField']),
             ),
             Divider(),
           ],
         ),
       ),
     ),
   );

  }

}