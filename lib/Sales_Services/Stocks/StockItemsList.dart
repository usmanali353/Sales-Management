import 'dart:convert';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/ProductVariations.dart';
import 'package:salesmanagement/PrePicking/SelectedProductsList.dart';
import 'StockItemsDetails.dart';

class StockItemsList extends StatefulWidget{
  var customerId,title;

  StockItemsList(this.title,this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _StockItemsList(this.title,this.customerId);
  }

}
class _StockItemsList extends ResumableState<StockItemsList>{
  var customerId,title,temp=['',''],items,isVisible=false,availableExpanded=true,finishedExpanded=false,olderExpanded=false;
  String searchQuery = "Search query";
  var filteredList=[],_isSearching=false,counter=0;
  sqlite_helper db;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery;
  _StockItemsList(this.title,this.customerId);
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
    }
    super.onResume();
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
    ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
    pd.show();
    Network_Operations.GetCustomerOlderStock(customerId).then((response){
      pd.dismiss();
      if(response!=null&&response!='[]'){
        setState(() {
          if(items!=null){
            items.clear();
          }
          items=jsonDecode(response);
          isVisible=true;
          if(filteredList!=null){
            filteredList.clear();
          }
          filteredList.addAll(items);
        });
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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Wrap(
                children: <Widget>[
                  FilterChip(
                    label: Text("OnHand Stock"),
                    selected: availableExpanded,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          availableExpanded = true;
                          olderExpanded = false;
                          finishedExpanded = false;
                        });
                        ProgressDialog pd = ProgressDialog(
                            context, isDismissible: true,
                            type: ProgressDialogType.Normal);
                        pd.show();
                        Network_Operations.GetOnhandStock(customerId).then((
                            response) {
                          pd.dismiss();
                          if (response != null && response != '[]') {
                            setState(() {
                              if (items != null) {
                                items.clear();
                              }
                              items = jsonDecode(response);
                              items.sort((a, b) {
                                return double.parse(b['OnhandALL'].toString())
                                    .compareTo(
                                    double.parse(a['OnhandALL'].toString()));
                              });
                              if(filteredList!=null){
                                filteredList.clear();
                              }
                               filteredList.addAll(items);
                              isVisible = true;
                            });
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(width: 6,),
                  FilterChip(
                    label: Text("Old Stock"),
                    selected: olderExpanded,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          availableExpanded = false;
                          olderExpanded = true;
                          finishedExpanded = false;
                        });
                        ProgressDialog pd = ProgressDialog(
                            context, isDismissible: true,
                            type: ProgressDialogType.Normal);
                        pd.show();
                        Network_Operations.GetCustomerOlderStock(customerId)
                            .then((response) {
                          pd.dismiss();
                          if (response != null && response != '[]') {
                            setState(() {
                              if (items != null) {
                                items.clear();
                              }
                              items = jsonDecode(response);
                              isVisible = true;
                              if(filteredList!=null){
                                filteredList.clear();
                              }
                              filteredList.addAll(items);
                            });
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(width: 6,),
                  FilterChip(
                    label: Text("Zero Stock"),
                    selected: finishedExpanded,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          availableExpanded = false;
                          olderExpanded = false;
                          finishedExpanded = true;
                        });
                        ProgressDialog pd = ProgressDialog(
                            context, isDismissible: true,
                            type: ProgressDialogType.Normal);
                        pd.show();
                        Network_Operations.GetCustomerOnHandNoStock(customerId,1,50)
                            .then((response) {
                          pd.dismiss();
                          if (response != null && response != '[]') {
                            setState(() {
                              if (items != null) {
                                items.clear();
                              }
                              items = jsonDecode(response);
                              isVisible = true;
                              if(filteredList!=null){
                                filteredList.clear();
                              }
                              filteredList.addAll(items);
                            });
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16, right: 16, left: 16),
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: ListView.builder(
                        itemCount: filteredList != null ? filteredList.length : temp.length,
                        itemBuilder: (context, int index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    filteredList[index]['ItemDescription'] != null
                                        ? filteredList[index]['ItemDescription']
                                        : ''),
                                leading: Material(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Colors.teal.shade100,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10,
                                          bottom: 15,
                                          right: 15,
                                          left: 10),
                                      child: Icon(
                                        FontAwesomeIcons.boxOpen, size: 30,
                                        color: Color(0xFF004c4c),),
                                    )
                                ),
                                subtitle: Text((() {
                                  if (filteredList[index]['OnhandALL'] != null) {
                                    return 'Quantity: ' +
                                        filteredList[index]['OnhandALL'].toString();
                                  } else
                                  if (filteredList[index]['QtyAvailablePhysical'] !=
                                      null) {
                                    return 'Quantity: ' +
                                        filteredList[index]['QtyAvailablePhysical']
                                            .toString();
                                  } else
                                    return 'Quantity: ' +
                                        items[index]['OnHandQty'].toString();
                                })()),
                                //Text(items[index]['OnhandALL']!=null?items[index]['OnhandALL'].toString():items[index]['QtyAvailablePhysical'].toString()),
                                onTap: () {
                                  if (!finishedExpanded) {
                                    push(context, MaterialPageRoute(
                                        builder: (context) => ProductVariations(items[index]['ItemNumber'], customerId)));
                                  } else {
                                    push(context, MaterialPageRoute(builder: (context) => StockItemDetail(items[index])));
                                  }
                                },
                              ),
                              Divider(),
                            ],
                          );
                        }),
                  ),
                ),
              ),
            )
          ],
        )
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
      filteredList.addAll(items);
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
            const Text('Products'),
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
        for(int i=0;i<items.length;i++){
          if(items[i]['ItemDescription'].toLowerCase().contains(searchQuery)){
            filteredList.add(items[i]);
          }
        }
      }else{
        filteredList.addAll(items);
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