import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'InvoiceLineDetails.dart';
import 'package:salesmanagement/Network_Operations.dart';
class InvoiceLines extends StatefulWidget{
var invoiceId;

InvoiceLines(this.invoiceId);

@override
  State<StatefulWidget> createState() {
    return _InvoiceLines(invoiceId);
  }

}
class _InvoiceLines extends State<InvoiceLines>{
  var isVisible=false,invoiceLineData,invoiceId,temp=['',''];

  _InvoiceLines(this.invoiceId);

  @override
  void initState() {
    ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
    pd.show();
    Network_Operations.GetInvoice(invoiceId).then((response){
      pd.dismiss();
      if(response!=null){
        setState(() {
          this.invoiceLineData=jsonDecode(response);
          this.isVisible=true;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: (Text("Invoice Lines")),),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
          itemCount: invoiceLineData['InvoiceLines']!=null?invoiceLineData['InvoiceLines'].length:temp.length,
            itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                   ListTile(
                     title: Text(invoiceLineData['InvoiceLines'][index]['ItemDescription']!=null?invoiceLineData['InvoiceLines'][index]['ItemDescription']:''),
                     trailing: Text(invoiceLineData['InvoiceLines'][index]['TotalAmount']!=null?"Total:"+invoiceLineData['InvoiceLines'][index]['TotalAmount'].toString():''),
                     subtitle: Text(invoiceLineData['InvoiceLines'][index]['LineAmount']!=null?"Line Amount:"+invoiceLineData['InvoiceLines'][index]['LineAmount'].toString():''),
                     leading: Icon(FontAwesomeIcons.fileInvoice,size: 30,),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>invoiceLineDetails(invoiceLineData['InvoiceLines'][index])));
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