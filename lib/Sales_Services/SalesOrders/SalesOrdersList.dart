import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import '../../Utils.dart';
import 'SalesOrderDetails.dart';

class SalesOrdersList extends StatefulWidget{
  var startDate,endDate,CustomerId,title;

  SalesOrdersList(this.startDate, this.endDate,this.CustomerId,this.title);

  @override
  State<StatefulWidget> createState() {
    return _SalesOrdersList(this.startDate, this.endDate,this.CustomerId,this.title);
  }

}
class _SalesOrdersList extends State<SalesOrdersList>{
  var startDate,endDate,order_data,temp=['',''],CustomerId,title,_isSearching=false;
  bool isVisible=false;
 String searchQuery = "Search query";
  TextEditingController _searchQuery;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  _SalesOrdersList(this.startDate, this.endDate,this.CustomerId,this.title);
 @override
  void initState() {
   _searchQuery=TextEditingController();
   Utils.check_connectivity().then((connected){
     if(connected){
       ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
       pd.show();
       Network_Operations.GetSalesOrders(startDate,endDate,CustomerId).then((response){
         pd.hide();
         if(response!=null){
           setState(() {
             this.order_data=json.decode(response);
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
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: Visibility(
        visible: isVisible,
        child: ListView.builder(
          itemCount: order_data!=null?order_data.length:temp.length,
          itemBuilder: (BuildContext context,int index){
          return Column(
            children: <Widget>[
          ListTile(
          title: Text(order_data[index]['salesIdField']!=null?order_data[index]['salesIdField'].toString():''),
            leading: Icon(Icons.local_shipping,size: 40,),
            trailing: Text(order_data[index]['salesStatusField']!=null?get_order_status(order_data[index]['salesStatusField']):''),
            onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>salesOrdersDetails(order_data[index])));
            },
            ),
              Divider(),
            ],
          );

          },
        ),
      ),
    );
  }
  String get_order_status(int num){
   String status="";
    if(num==0){
        status="None";
    }else if(num==1){
        status="Backorder";
    }else if(num==2){
        status="Delivered";
    }else if(num==3){
        status="Invoiced";
    }else if(num==4){
        status="Canceled";
    }
    return status;
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
             Text(title),
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
      searchQuery = newQuery;
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
    ];
  }

}