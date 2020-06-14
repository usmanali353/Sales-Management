import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/OrderedProductQty.dart';
import 'package:salesmanagement/Production_Request/CreateProductionRequest.dart';
import 'package:salesmanagement/Utils.dart';
class VariationDetails extends StatefulWidget {
  var variationData,forDetail;

  VariationDetails(this.variationData,this.forDetail);

  @override
  _VariationDetailsState createState() => _VariationDetailsState(variationData,forDetail);
}

class _VariationDetailsState extends ResumableState<VariationDetails> {
  var variationData,pendingRequests=0,selectedPreference,forDetail;
 sqlite_helper db;
 TextEditingController quantity;
  _VariationDetailsState(this.variationData,this.forDetail);

  @override
  void onResume() {
    if(resume.data.toString()=='Close'){
      Navigator.pop(context,'Close');
    }
  }

  @override
  void initState() {
   quantity=TextEditingController();
   db=sqlite_helper();
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.GetProdRequestListByItemNotFinished('LC0001', variationData['ItemNumber'], 1, 100).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
             var requests=jsonDecode(response);
             if(requests!=null&&requests.length>0){
               for(int i=0;i<requests.length;i++){
                 pendingRequests=pendingRequests+requests[i]['QuantityRequested'];
               }
             }
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
      appBar: AppBar(
        title: Text("Variation Details"),
        actions: <Widget>[
        !forDetail? Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: (){
                showAlertDialog(context,null,null);
              },
              child: Center(child: Text("Order")),
            ),
          ):Container(),
        ],
      ),
      body: ListView(
        children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Center(
                child: Text("Item Info",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16,left: 16,right:16),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Item Number"),
                      subtitle: Text(variationData['ItemNumber']),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Name"),
                      subtitle: Text(variationData['ItemDescription']),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Color"),
                      subtitle: Text(variationData['ItemColor']),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Size"),
                      subtitle: Text(variationData['ItemSize']),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Grade"),
                      subtitle: Text(variationData['ItemGrade']),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Inventory Dimension"),
                      subtitle: Text(variationData['InventoryDimension']),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Center(
                child: Text("Stock Info",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16,bottom: 16),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("OnHand Stock"),
                      subtitle: Text(variationData['Onhand'].toString()),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Undelivered Stock"),
                      subtitle: Text(variationData['OnOrdered'].toString()),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Pending Production Requests"),
                      subtitle: Text(pendingRequests!=null?pendingRequests.toString():'0'),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Available Stock"),
                      subtitle: Text(variationData['Onhand']-variationData['OnOrdered']>1?(variationData['Onhand']-variationData['OnOrdered']).toString():'0'),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context,var stock,var quantity) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Select your Preference"),
      content: StatefulBuilder(
        builder: (context, setState) {
           return Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               RadioListTile(
                 title: Text("Order"),
                 value:'Order',
                 groupValue: selectedPreference,
                 onChanged: (choice){
                   setState(() {
                    this.selectedPreference=choice;
                    selectedPreference=null;
                    Navigator.pop(context);
                    push(context, MaterialPageRoute(builder: (context)=>OrderedProductQty(variationData)));
                   });
                 },
               ),
               RadioListTile(
                 title: Text("Production Request"),
                 value:'Production Request',
                 groupValue: selectedPreference,
                 onChanged: (choice){
                   setState(() {
                     this.selectedPreference=choice;
                     Navigator.pop(context);
                     selectedPreference=null;
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateProductionRequest(),
                         settings: RouteSettings(
                             arguments: {'itemName':variationData['ItemDescription'].toString(),'ItemSize':variationData['ItemSize'].toString()}
                         )));

                   });
                 },
               ),
             ],
           );
        },
      ),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
