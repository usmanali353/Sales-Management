import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'InvoiceLineDetails.dart';
import 'package:acmc_customer/Network_Operations.dart';
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
      appBar: AppBar(title: (Text("Invoice Lines"))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: ListView.builder(
            itemCount: invoiceLineData['InvoiceLines']!=null?invoiceLineData['InvoiceLines'].length:temp.length,
              itemBuilder: (context,int index){
                return Column(
                  children: <Widget>[
                     ListTile(
                       title: Text(invoiceLineData['InvoiceLines'][index]['ItemDescription']!=null?invoiceLineData['InvoiceLines'][index]['ItemDescription']:''),
                       subtitle: Text(invoiceLineData['InvoiceLines'][index]['TotalAmount']!=null?"Total:"+invoiceLineData['InvoiceLines'][index]['TotalAmount'].toString():''),
                      // subtitle: Text(invoiceLineData['InvoiceLines'][index]['LineAmount']!=null?"Without Tax Amount:"+invoiceLineData['InvoiceLines'][index]['LineAmount'].toString():''),
                       leading: Material(
                borderRadius: BorderRadius.circular(24),
                color: Colors.teal.shade100,
                child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 16,right: 10,left: 10),
                child: Icon(FontAwesomeIcons.fileInvoice,size: 30,color: Color(0xFF004c4c),),
                )
                ),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>invoiceLineDetails(invoiceLineData['InvoiceLines'][index])));
                       },
                     ),
                    Divider(),
                  ],
                );
              }),
        ),
      ),
    );
  }

}