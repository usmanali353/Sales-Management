import 'dart:convert';
import 'dart:io';
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
  var stockItems=[],isVisible=false,selectedItemStock,truckNumber,deliveryDate,mobileNo,address,driverName,totalProductionRequests=0,counter=0,_isSearching=false;
  sqlite_helper db;
 String searchQuery = "Search query";
  var filteredList=[];
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map> prePickingLines=[];
  var productsList=[];

  TextEditingController quantity,_searchQuery;
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
    _searchQuery=TextEditingController();
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
                stockItems.sort((a,b){
                  return double.parse(a['OnhandALL'].toString()).compareTo(double.parse(b['OnhandALL'].toString()));
                });
                filteredList.addAll(stockItems);
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
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListView.builder(itemCount:filteredList!=null?filteredList.length:0,itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(filteredList[index]['ItemDescription']),
                    subtitle: Text('onHand: '+filteredList[index]['OnhandALL'].toString()),
                    leading:  Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.teal.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                          child: Icon(FontAwesomeIcons.boxOpen,size: 30,color: Color(0xFF004c4c),),
                        )
                    ),
                    onTap: (){
                      this.selectedItemStock=filteredList[index]['OnhandALL'];
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
                              showQuantityDialog(context,filteredList[index]);
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text("OnHand Stock"),
            trailing: Text('$selectedItemStock'),
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
  void _startSearch() {
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
      filteredList.addAll(stockItems);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Add Products'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      filteredList.clear();
      searchQuery = newQuery;
      if(searchQuery.length>0){
        for(int i=0;i<stockItems.length;i++){
          if(stockItems[i]['ItemDescription'].toLowerCase().contains(searchQuery)){
            filteredList.add(stockItems[i]);
          }
        }
      }else{
         filteredList.addAll(stockItems);
      }

    });
  }

  List<Widget> _buildActions() {

    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      InkWell(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
                "Selected  ($counter)"
            ),
          ),
        ),
        onTap: (){
          push(context, MaterialPageRoute(builder: (context)=>SelectedProducts(deliveryDate,driverName,truckNumber,address,mobileNo)));
        },
      ),
    ];
  }
}
