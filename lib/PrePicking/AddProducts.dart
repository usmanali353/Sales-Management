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
class AddProducts extends StatefulWidget {
 var  truckNumber,deliveryDate,mobileNo,address,driverName;
 AddProducts(this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);
  @override
  _AddProductsState createState() => _AddProductsState(deliveryDate,driverName,truckNumber,address,mobileNo);
}

class _AddProductsState extends ResumableState<AddProducts> {
  var stockItems,isVisible=false,selectedItemStock,truckNumber,deliveryDate,mobileNo,address,driverName,totalProductionRequests=0,counter=0;
  sqlite_helper db;
  List<Map> prePickingLines=[];
  var productsList=[];
  TextEditingController quantity;
  _AddProductsState(this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);

  @override
  void onResume() {
    print("Data "+resume.data.toString());
    if(resume.data.toString()=='Refresh') {
      Navigator.pop(context,'Close');
    }
  }

  @override
  void initState() {
    quantity=TextEditingController();
    db=sqlite_helper();
    db.getProducts().then((product){
      print(product.length);
      if(product.length>0){
        setState(() {
          this.counter=product.length;
        });
      }
    });
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog dialog=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        try{
          dialog.show();
        Network_Operations.GetOnhandStock("LC0001").then((response){
          dialog.dismiss();
          if(response!=null){
            setState(() {
              stockItems=jsonDecode(response);
              if(stockItems!=null&&stockItems.length>0){
                isVisible=true;
              }
            });
          }
        });
      }catch(e){
          dialog.dismiss();
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Products"),
        actions: <Widget>[
          InkWell(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  "Selected Products ($counter)"
                ),
              ),
            ),
            onTap: (){
              push(context, MaterialPageRoute(builder: (context)=>SelectedProducts(deliveryDate,driverName,truckNumber,address,mobileNo)));
            },
          ),
        ],
      ),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(itemCount:stockItems!=null?stockItems.length:0,itemBuilder: (BuildContext context,int index){
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(stockItems[index]['ItemDescription']),
                leading: Icon(FontAwesomeIcons.box),
                onTap: (){
                  this.selectedItemStock=stockItems[index]['OnhandALL'];
                  ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                  pd.show();
                  Network_Operations.GetProdRequestListByItemNotFinished("LC0001",stockItems[index]['ItemNumber'], 1, 10).then((response){
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
                          showQuantityDialog(context,stockItems[index]);
                          });
                    }
                  });

                },
              ),
              Divider(),
            ],
          );
        }),
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
        Network_Operations.GetProductInfo(stock['ItemNumber']).then((response){
          if(response!=null){
            setState(() {
              var info=jsonDecode(response);
              prePickingLines.clear();
              db.checkAlreadyExists(stock['ItemNumber']).then((alreadyExists){
                if(alreadyExists.length>0){
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("product Already Exists"),
                    backgroundColor: Colors.red,
                  ));
                }else{
                  Products p=Products(stock['ItemDescription'],stock['ItemNumber'],info['ItemSize'],'','','','',double.parse(quantity));
                  db.addProducts(p);
                  db.getProducts().then((product){
                    if(product.length>0){
                      setState(() {
                        this.counter=product.length;
                      });
                    }
                  });
                }
              });
              Navigator.pop(context);
            });

          }
        });

      },
    );
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
      content: Text("You have $selectedItemStock SQM available for this item"+'\n'+'and having $totalProductionRequests SQM production Requests Pending'),
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
