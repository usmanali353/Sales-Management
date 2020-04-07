import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Network_Operations.dart';
import 'DeliveryDetails.dart';

class DeliveryList extends StatefulWidget{
  String date;
  var CustomerId;
  DeliveryList(this.date,this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeliveryList(date,CustomerId);
  }

}
class _DeliveryList extends State<DeliveryList>{
  bool isVisible=false;
  var orders_list,temp=['',''],CustomerId;
  String date;

  _DeliveryList(this.date,this.CustomerId);

  @override
  void initState() {
    ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
    pd.show();
    Network_Operations.get_deliveries(date,CustomerId).then((response){
      pd.dismiss();
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
    return Scaffold(
      appBar: AppBar(title: Text('Deliveries'),),
      body: Visibility(
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
    );
  }

}