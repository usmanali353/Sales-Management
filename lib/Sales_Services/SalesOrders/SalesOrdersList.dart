import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'SalesOrderDetails.dart';

class SalesOrdersList extends StatefulWidget{
  var startDate,endDate,CustomerId;

  SalesOrdersList(this.startDate, this.endDate,this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    return _SalesOrdersList(this.startDate, this.endDate,this.CustomerId);
  }

}
class _SalesOrdersList extends State<SalesOrdersList>{
  var startDate,endDate,order_data,temp=['',''],CustomerId;
  bool isVisible=false;
  _SalesOrdersList(this.startDate, this.endDate,this.CustomerId);
 @override
  void initState() {
   ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
   pd.show();
    Network_Operations.GetSalesOrders(startDate, endDate,CustomerId).then((response){
      pd.dismiss();
      if(response!=null){
        setState(() {
          this.order_data=json.decode(response);
          this.isVisible=true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sales Orders"),),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
          itemCount: order_data!=null?order_data.length:temp.length,
          itemBuilder: (BuildContext context,int index){
          return Column(
            children: <Widget>[
          ListTile(
          title: Text(order_data[index]['salesIdField']!=null?order_data[index]['salesIdField'].toString():''),
            leading: Icon(Icons.local_shipping,size: 40,),
            trailing: Text(order_data[index]['salesStatusField']!=null?get_order_status(order_data[index]['salesStatusField']):''),
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>salesOrdersDetails(order_data[index])));
            },
            ),
              Divider(),
            ],
          );

          },
        ),
      ),
    );
  }
  String get_order_status(int num){
   String status="";
    if(num==0){
        status="None";
    }else if(num==1){
        status="Backorder";
    }else if(num==2){
        status="Delivered";
    }else if(num==3){
        status="Invoiced";
    }else if(num==4){
        status="Canceled";
    }
    return status;
  }

}