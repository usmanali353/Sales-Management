import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/InvoiceDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';

class InvoicesList extends StatefulWidget{
  var CustomerId;

  InvoicesList(this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InvoicesList(CustomerId);
  }

}
class _InvoicesList extends State<InvoicesList>{
  var InvoiceList,CustomerId,isVisible=false,temp=['',''];

  _InvoicesList(this.CustomerId);
  @override
  void initState() {
     Network_Operations.GetCustomerInvoices(CustomerId, 1, 10).then((response){
       if(response!=null){
         setState(() {
           this.InvoiceList=json.decode(response);
           this.isVisible=true;
         });
       }
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Invoices"),),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
          itemCount: InvoiceList!=null?InvoiceList.length:temp.length,
            itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                 ListTile(
                   title: Text(InvoiceList[index]['InvoiceId']!=null?InvoiceList[index]['InvoiceId']:''),
                   subtitle: Text(InvoiceList[index]['InvoiceDate']!=null?InvoiceList[index]['InvoiceDate']:''),
                   trailing: Text(InvoiceList[index]['InvoiceAmount']!=null?InvoiceList[index]['InvoiceAmount'].toString():''),
                   leading: Icon(FontAwesomeIcons.fileInvoice,size: 40,),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoiceDetails(InvoiceList[index])));
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