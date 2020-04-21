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
               subtitle: Text(orders_data['salesNameField']),
             ),
             Divider(),
             ListTile(
               title: Text("Order id"),
               subtitle: Text(orders_data['salesIdField']),
             ),
             Divider(),
             ListTile(
               title: Text("Delivery Date"),
               subtitle: Text(DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data['deliveryDateField'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
             ),
             Divider(),
             ListTile(
               title: Text("Delivery Name"),
               subtitle: Text(orders_data['deliveryNameField']),
             ),
             Divider(),
             ListTile(
               title: Text("Truck Number"),
               subtitle: Text(orders_data['truckPlateField']),
             ),
             Divider(),
             ListTile(
               title: Text("Start Load"),
               subtitle: Text(orders_data['startLoadField']),
             ),
             Divider(),
             ListTile(
               title: Text("Stop Load"),
               subtitle: Text(orders_data['stopLoadField']),
             ),
             Divider(),
           ],
         ),
       ),
     ),
   );

  }

}