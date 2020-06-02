import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Request/CreateProductionRequest.dart';
import '../Utils.dart';
import 'SelectedProductsList.dart';
class ProductVariations extends StatefulWidget {
  var itemNumber,deliveryDate, driverName, truckNumber,address,mobileNo;

  ProductVariations(this.itemNumber,this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);

  @override
  _ProductVariationsState createState() => _ProductVariationsState(itemNumber,deliveryDate, driverName, truckNumber,address,mobileNo);
}

class _ProductVariationsState extends ResumableState<ProductVariations> {
  var itemNumber,db,total,totalProductionRequests=0,deliveryDate, driverName, truckNumber,address,mobileNo;
  var isVisible=false;
  var variations;
  TextEditingController quantity;
  _ProductVariationsState(this.itemNumber,this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);
 @override
  void initState() {
   quantity=TextEditingController();
   db=sqlite_helper();

    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.GetOnhandStockByItem("LC0001",itemNumber).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              variations=jsonDecode(response);
              isVisible=true;
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
          title:Text('Available Variations'),
      ),
      body: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: ListView.builder(itemCount:variations!=null?variations.length:0,itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(variations[index]['ItemSize']),
                    trailing: Text('Color: '+variations[index]['ItemColor']),
                    subtitle: Text('OnHand: '+variations[index]['Onhand'].toString()),
                    leading:  Material(
              borderRadius: BorderRadius.circular(24),
              color: Colors.teal.shade100,
              child: Padding(
              padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
              child: Icon(FontAwesomeIcons.boxes,size: 30,color: Color(0xFF004c4c),),
              )
              ),
                    onTap: (){
                      ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                      pd.show();
                      Network_Operations.GetProdRequestListByItemNotFinished("LC0001",variations[index]['ItemNumber'], 1, 10).then((response){
                        pd.dismiss();
                        if(response!=null){
                              setState(() {
                                totalProductionRequests=0;
                              var prodRequests=jsonDecode(response);
                              if(prodRequests!=null&&prodRequests.length>0){
                                for(int i=0;i<prodRequests.length;i++){
                                  totalProductionRequests=totalProductionRequests+prodRequests[i]['QuantityRequested'];
                                }
                              }
                              showQuantityDialog(context,variations[index]);
                              });
                        }
                      });
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
  showQuantityDialog(BuildContext context,var stock){
    Widget addQuantityButton = FlatButton(
      child: Text("Add Quantity"),
      onPressed:  () {
        setState(() {
          Navigator.pop(context);
          showAlertDialog(context, stock, quantity.text);
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
  showAlertDialog(BuildContext context,var stock,var quantity) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget orderButton = FlatButton(
      child: Text("Add Product"),
      onPressed:  () {
        db.checkAlreadyExists(stock['ItemNumber']).then((alreadyExists){
          if(alreadyExists.length>0){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Product Already Exists"),
              backgroundColor: Colors.red,
            ));
          }else{
            Products p=Products(stock['ItemDescription'],stock['ItemNumber'],stock['ItemSize'],stock['InventoryDimension'],stock['ItemColor'],'',stock['ItemGrade'],double.parse(quantity));
          db.addProducts(p);
          db.getProducts().then((product){
          if(product.length>0){
           Navigator.pop(context,'Refresh');
          }
          });
        }
        });
        Navigator.pop(context);
      });
    Widget prodRequestButton = FlatButton(
      child: Text("Production Request"),
      onPressed:  () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProductionRequest()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("OnHand Stock"),
            trailing: Text(stock['Onhand'].toString()),
          ),
          Divider(),
          ListTile(
            title: Text("Pending Production Requests"),
            trailing: Text('$totalProductionRequests'),
          ),
          Divider(),
          ListTile(
            title: Text("Selected Quantity"),
            trailing: Text('$quantity'),
          ),
          Divider(),
        ],
      ),
//      content: RichText(
//        text: TextSpan(
//          children: [
//            TextSpan(text: "You have ",style: TextStyle(color: Colors.black)),
//            TextSpan(text: "$selectedItemStock",style:Theme.of(context).textTheme.body1),
//            TextSpan(text: " SQM available for this item"+'\n'+'and having ',style: Theme.of(context).textTheme.body1),
//            TextSpan(text: "$totalProductionRequests",style: TextStyle(color: Color(0xFF004c4c),fontWeight: FontWeight.bold)),
//            TextSpan(text: " SQM production Requests Pending",style:Theme.of(context).textTheme.body1),
//          ]
//        ),
//      ), //Text("You have $selectedItemStock SQM available for this item"+'\n'+'and having $totalProductionRequests SQM production Requests Pending'),
      actions: [
        orderButton,
        cancelButton,
        prodRequestButton,
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
