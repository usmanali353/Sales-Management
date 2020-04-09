import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'InvoiceLineDetails.dart';
import 'package:salesmanagement/Network_Operations.dart';
class InvoiceLines extends StatefulWidget{
var invoiceLineData;

InvoiceLines(this.invoiceLineData);

@override
  State<StatefulWidget> createState() {
    return _InvoiceLines(invoiceLineData);
  }

}
class _InvoiceLines extends State<InvoiceLines>{
  var invoiceLineData,temp=['',''];

  _InvoiceLines(this.invoiceLineData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text("Invoice Lines")),),
      body: ListView.builder(
        itemCount: invoiceLineData['InvoiceLines']!=null?invoiceLineData['InvoiceLines'].length:temp.length,
          itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                 ListTile(
                   title: Text(invoiceLineData['InvoiceLines'][index]['ItemDescription']!=null?invoiceLineData['InvoiceLines'][index]['ItemDescription']:''),
                   trailing: Text(invoiceLineData['InvoiceLines'][index]['TotalAmount']!=null?"Total:"+invoiceLineData['InvoiceLines'][index]['TotalAmount'].toString():''),
                   subtitle: Text(invoiceLineData['InvoiceLines'][index]['LineAmount']!=null?"Without Tax Amount:"+invoiceLineData['InvoiceLines'][index]['LineAmount'].toString():''),
                   leading: Icon(FontAwesomeIcons.fileInvoice,size: 30,),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>invoiceLineDetails(invoiceLineData['InvoiceLines'][index])));
                   },
                 ),
                Divider(),
              ],
            );
          }),
    );
  }

}