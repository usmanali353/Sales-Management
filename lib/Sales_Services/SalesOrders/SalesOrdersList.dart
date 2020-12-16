import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Network_Operations.dart';
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
  var startDate,endDate,order_data,temp=['',''],CustomerId,title,_isSearching=false,filteredList=[];
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
       Network_Operations.GetSalesOrders(context,startDate,endDate,CustomerId).then((response){
         if(response!=null){
           setState(() {
             this.order_data=json.decode(response);
             if(order_data!=null&&order_data.length>0){
               this.isVisible=true;
               filteredList.addAll(order_data);
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
            child: ListView.builder(
              itemCount: filteredList!=null?filteredList.length:temp.length,
              itemBuilder: (BuildContext context,int index){
              return Column(
                children: <Widget>[
              ListTile(
              title: Text(filteredList[index]['deliveryNameField']!=null?filteredList[index]['deliveryNameField'].toString().trim():''),
                subtitle: Text(filteredList[index]['salesStatusField']!=null?get_order_status(filteredList[index]['salesStatusField']):''),
                trailing:  Text(filteredList[index]['deliveryDateField']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(filteredList[index]['deliveryDateField'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                leading: Material(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.teal.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.local_shipping,size: 30,color: Color(0xFF004c4c),),
                    )
                ),
               // trailing: Text(order_data[index]['salesStatusField']!=null?get_order_status(order_data[index]['salesStatusField']):''),
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>salesOrdersDetails(filteredList[index])));
                },
                ),
                  Divider(),
                ],
              );

              },
            ),
          ),
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
      filteredList.addAll(order_data);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      filteredList.clear();
      filteredList.addAll(order_data);
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
      filteredList.clear();
      searchQuery = newQuery;
      if(searchQuery.length>0){
        for(int i=0;i<order_data.length;i++){
          if(order_data[i]['salesIdField'].toLowerCase().contains(searchQuery)){
            filteredList.add(order_data[i]);
          }
        }
      }else{
        filteredList.addAll(order_data);
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
    ];
  }

}