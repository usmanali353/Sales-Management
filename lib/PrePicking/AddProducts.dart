import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Model/sqlite_helper.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/PrePicking/ProductVariations.dart';
import 'package:acmc_customer/PrePicking/SelectedProductsList.dart';
import '../Utils.dart';
class AddProducts extends StatefulWidget {
 var  customerId;
 AddProducts(this.customerId);
  @override
  _AddProductsState createState() => _AddProductsState(customerId);
}

class _AddProductsState extends ResumableState<AddProducts> {
  var counter=0,stockItems=[],isVisible=false,truckNumber,deliveryDate,mobileNo,address,driverName,_isSearching=false,customerId;
  sqlite_helper db;
 String searchQuery = "Search query";
  var filteredList=[];
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var productsList=[];
  TextEditingController _searchQuery;
  _AddProductsState(this.customerId);

  @override
  void onResume() {
    print("Data " + resume.data.toString());
    if (resume.data.toString() == 'Refresh') {
      db.getProducts().then((product){
        print(product.length);
        if(product.length>0){
          setState(() {
            this.counter=product.length;
          });
        }
      });
    }else if(resume.data.toString() == 'Close'){
      Navigator.pop(context,'Close');
      Navigator.pop(context,'Close');
    }
  }

  @override
  void initState() {
    _searchQuery=TextEditingController();
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
        Network_Operations.GetOnhandStock(context,customerId).then((response){
          if(response!=null){
            setState(() {
              stockItems=jsonDecode(response);
              if(stockItems!=null&&stockItems.length>0){
                stockItems.sort((a,b){
                  return double.parse(b['OnhandALL'].toString()).compareTo(double.parse(a['OnhandALL'].toString()));
                });
                filteredList.addAll(stockItems);
                isVisible=true;
              }
            });
          }
        });
      }else{
        Flushbar(
          message: "Network not Available",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        )..show(context);
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
                    subtitle: Text('onHand: '+filteredList[index]['OnhandALL'].toStringAsFixed(2).toString()),
                    leading:  Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.teal.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                          child: Icon(FontAwesomeIcons.boxOpen,size: 30,color: Color(0xFF004c4c),),
                        )
                    ),
                    onTap: (){
                      push(context, MaterialPageRoute(builder: (context)=>ProductVariations(filteredList[index]['ItemNumber'],customerId)));
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
      Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: (){
            push(context, MaterialPageRoute(builder: (context)=>SelectedProducts(customerId)));
          },
          child: Badge(
            badgeContent: Text('$counter',style: TextStyle(color: Colors.white),),
            child: Icon(Icons.shopping_basket),
            showBadge: counter==0?false:true,
          ),
        ),
      ),
    ];
  }
}
