import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';

import '../Network_Operations.dart';
class SelectedProducts extends StatefulWidget {
  var truckNumber,deliveryDate,mobileNo,address,driverName;

  SelectedProducts(this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);

  @override
  _SelectedProductsState createState() => _SelectedProductsState(deliveryDate, driverName, truckNumber,address,mobileNo);
}

class _SelectedProductsState extends State<SelectedProducts> {
  sqlite_helper db;
  List<Products> productList=[];
  List<Map> prePickingLines=[];
  var truckNumber,deliveryDate,mobileNo,address,driverName;
  _SelectedProductsState(this.deliveryDate, this.driverName, this.truckNumber,this.address,this.mobileNo);
  @override
  void initState() {
    db=sqlite_helper();
    db.getProducts().then((product){
      if(product.length>0){
        setState(() {
          for(int i=0;i<product.length;i++){
            productList.add(Products.fromMap(product[i]));
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
        title: Text("Selected Products"),
        actions: <Widget>[
          InkWell(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text("Proceed"),
              ),
            ),
            onTap: (){
              for(int i=0;i<productList.length;i++){
                prePickingLines.add(
                {
                "ColorItem":"",
                "Grade":"",
                "ItemNumber":productList[i].ItemNumber,
                "PickingId":"",
                "InventoryDimension":"",
                "SalesQuantity":productList[i].SalesQuantity,
                "SizeItem":productList[i].SizeItem
                }
                );
              }
              ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
              try{
                pd.show();
                Network_Operations.CreatePrePicking("LC0001", address, driverName, truckNumber,'/Date('+deliveryDate.millisecondsSinceEpoch.toString()+'+0300)/', mobileNo, prePickingLines).then((response){
                  pd.dismiss();
                  if(response!=null){
                    setState(() {
                      db.deleteProducts().then((deletedProducts){
                        if(deletedProducts>0){
                          setState(() {
                            productList.clear();
                          });
                        }
                      });
                    });
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text("Pre Picking Added"),
//                        backgroundColor: Colors.green,
//                      ));
                    Navigator.pop(context,'Refresh');
                  }else{
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                        content: Text("Pre Picking Not Added"),
//                        backgroundColor: Colors.red,
//                      ));
                  }
                });
              }catch(e){
                pd.dismiss();
              }

            },
          )
        ],
      ),
      body: ListView.builder(itemCount:productList.length,itemBuilder:(BuildContext context,int index){
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(productList[index].ItemNumber!=null?productList[index].ItemNumber:''),
              leading: Icon(FontAwesomeIcons.box),
            ),
            Divider(),

          ],
        );
      }),
    );
  }
}
