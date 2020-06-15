import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
import 'InvoiceDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';

class InvoicesList extends StatefulWidget{
  var CustomerId;

  InvoicesList(this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    return _InvoicesList(CustomerId);
  }

}
class _InvoicesList extends State<InvoicesList>{
  var InvoiceList,CustomerId,isVisible=false,temp=['',''];

  _InvoicesList(this.CustomerId);
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        Network_Operations.GetCustomerInvoices(CustomerId, 1, 10).then((response){
          pd.hide();
          if(response!=null){
            setState(() {
              this.InvoiceList=json.decode(response);
              this.isVisible=true;
            });
          }
        });
      }
    });
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: ListView.builder(
              itemCount: InvoiceList!=null?InvoiceList.length:temp.length,
                itemBuilder: (context,int index){
                  return Column(
                    children: <Widget>[
                     ListTile(
                       title: Text(InvoiceList[index]['InvoiceId']!=null?InvoiceList[index]['InvoiceId']:''),
                       subtitle: Text(InvoiceList[index]['InvoiceDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(InvoiceList[index]['InvoiceDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                       trailing: Text(InvoiceList[index]['InvoiceAmount']!=null?'Total:'+InvoiceList[index]['InvoiceAmount'].toString():''),
                       leading: Material(
                           borderRadius: BorderRadius.circular(24),
                           color: Colors.teal.shade100,
                           child: Padding(
                             padding: const EdgeInsets.only(top: 10,bottom: 16,right: 10,left: 10),
                             child: Icon(FontAwesomeIcons.fileInvoice,size: 30,color: Color(0xFF004c4c),),
                           )
                       ),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoiceDetails(InvoiceList[index])));
                       },
                     ),
                      Divider(),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

}