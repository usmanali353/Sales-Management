import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/Products.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/PrePicking/AddPrePicking.dart';
import '../Network_Operations.dart';
class SelectedProducts extends StatefulWidget {
  var customerId;

  SelectedProducts(this.customerId);

  @override
  _SelectedProductsState createState() => _SelectedProductsState(customerId);
}

class _SelectedProductsState extends ResumableState<SelectedProducts> {
  sqlite_helper db;
  List<Products> productList=[];
  List<Map> prePickingLines=[];
  var truckNumber,deliveryDate,mobileNo,address,driverName,totalQuantity=0.0,customerId;
  _SelectedProductsState(this.customerId);
  @override
  void onResume() {
    print('Data '+resume.data.toString());
    Navigator.pop(context,'Refresh');
    setState(() {
      if(productList!=null){
        productList.clear();
      }
      totalQuantity=0.0;

    });
  }
  @override
  void initState() {
    db=sqlite_helper();
    db.getProducts().then((product){
      if(product.length>0){
        setState(() {
          for(int i=0;i<product.length;i++){
            productList.add(Products.fromMap(product[i]));
          }
          for(int i=0;i<productList.length;i++){
            totalQuantity=totalQuantity+productList[i].SalesQuantity;
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
               Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AddPrePicking(customerId)));
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context,'Refresh');
          return false;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 8,bottom: 8),
              child: Center(child: Text('Total Quantity: $totalQuantity',style: TextStyle(fontSize: 20),)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right:16,bottom:16),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListView.builder(itemCount:productList.length,itemBuilder:(BuildContext context,int index){
                    return Column(
                      children: <Widget>[
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.20,
                          closeOnScroll: true,
                          actions: <Widget>[
                            IconSlideAction(
                              color: Colors.red,
                              icon: Icons.delete,
                              caption: "Delete",
                              closeOnTap: true,
                              onTap: (){
                                db.deleteProductsById(productList[index].ItemNumber).then((deletedProducts){
                                  if(deletedProducts>0){
                                    productList.clear();
                                    setState(() {
                                      db.getProducts().then((product){
                                        print(product.length);
                                        if(product.length>0){
                                          setState(() {
                                            for(int i=0;i<product.length;i++){
                                              productList.add(Products.fromMap(product[i]));
                                            }
                                            this.totalQuantity=0.0;
                                          });
                                        }
                                      });
                                    });
                                  }
                                });
                              },
                            ),
                          ],
                          child: ExpansionTile(
                            title:Text(productList[index].ItemName!=null?productList[index].ItemName:''),
                            subtitle: Text(productList[index].SalesQuantity!=null?'Quantity: '+productList[index].SalesQuantity.toString():''),
                            leading: Material(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.teal.shade100,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                                  child: Icon(FontAwesomeIcons.boxes,size: 30,color: Color(0xFF004c4c),),
                                )
                            ),
                            children: <Widget>[
                              ListTile(
                                title: Text("Item Size"),
                                trailing: Text(productList[index].SizeItem),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Item Color"),
                                trailing: Text(productList[index].ColorItem),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Item Grade"),
                                trailing: Text(productList[index].Grade),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
