import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/CreateProductionRequest.dart';
import 'package:salesmanagement/Utils.dart';
class VariationDetails extends StatefulWidget {
  var variationData;

  VariationDetails(this.variationData);

  @override
  _VariationDetailsState createState() => _VariationDetailsState(variationData);
}

class _VariationDetailsState extends State<VariationDetails> {
  var variationData,pendingRequests=0,selectedPreference,quantity,db;

  _VariationDetailsState(this.variationData);
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: (){

              },
              child: Center(child: Text("Order")),
            ),
          )
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
              padding: const EdgeInsets.only(left: 16,right:16),
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
            Builder(
              builder: (BuildContext context){
                return  Padding(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    onTap: (){
                      showAlertDialog(context,null,null);
                    },
                    child: Center(
                      child: Text("Order/Production Request"),
                    ),
                  ),
                );
              },

            )
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
    Widget orderButton = FlatButton(
        child: Text("Ok"),
        onPressed:  () {
          print(selectedPreference);
          if(selectedPreference.contains('Order')){
            showQuantityDialog(context,variationData);
            Navigator.pop(context);
          }else if(selectedPreference.contains('Production Request')){
             Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateProductionRequest(),
                 settings: RouteSettings(
               arguments: {'itemName':variationData['ItemDescription'],'ItemSize':variationData['ItemSize']}
             )));
          }
//          db.checkAlreadyExists(stock['ItemNumber']).then((alreadyExists){
//            if(alreadyExists.length>0){
//              Scaffold.of(context).showSnackBar(SnackBar(
//                content: Text("Product Already Exists"),
//                backgroundColor: Colors.red,
//              ));
//            }else{
//              Products p=Products(stock['ItemDescription'],stock['ItemNumber'],stock['ItemSize'],stock['InventoryDimension'],stock['ItemColor'],'',stock['ItemGrade'],double.parse(quantity));
//              db.addProducts(p);
//              db.getProducts().then((product){
//                if(product.length>0){
//                  Navigator.pop(context,'Refresh');
//                }
//              });
//            }
//          });
          Navigator.pop(context);
        });
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
        orderButton,

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
  showQuantityDialog(BuildContext context,var stock){
    Widget addQuantityButton = FlatButton(
      child: Text("Add Quantity"),
      onPressed:  () {
        setState(() {
          var as=stock['Onhand']-stock['OnOrdered']>1?stock['Onhand']-stock['OnOrdered']:0.0;
          print(stock['OnOrdered'].toString());
          if(quantity.text==null||quantity.text==""){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Enter Quantity"),
              backgroundColor: Colors.red,
            ));
          } else if(stock['Onhand']-stock['OnOrdered']<2.0){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("OnHand Stock too low to order"),
              backgroundColor: Colors.red,
            ));
          }else if(double.parse(quantity.text)>=as){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Quantity should be less the the OnHand Stock"),
              backgroundColor: Colors.red,
            ));
          }else{
            Navigator.pop(context);
            //showAlertDialog(context, stock, quantity.text);
          }
        });
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Add Quantity"),
      content: TextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: quantity,
        decoration: InputDecoration(
          hintText: "Enter Quantity",
        ),
      ),
      actions: [
        addQuantityButton,
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
