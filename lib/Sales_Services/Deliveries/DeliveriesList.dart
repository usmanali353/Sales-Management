import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/detail_page.dart';
import '../../Network_Operations.dart';
import '../../Utils.dart';
import 'DeliveryDetails.dart';

class DeliveryList extends StatefulWidget{

 var date,customerId;

 DeliveryList(this.date, this.customerId);

 @override
  State<StatefulWidget> createState() {
    return _DeliveryList(date,customerId);
  }

}
class _DeliveryList extends State<DeliveryList>{
  bool isVisible=false;
  var orders_list,temp=['',''],CustomerId,_isSearching=false,filteredList=[];
  String date,searchQuery = "Search query";
  TextEditingController _searchQuery;
  _DeliveryList(this.date,this.CustomerId);
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _searchQuery=TextEditingController();
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.get_deliveries(date,CustomerId).then((response){
          pd.hide();
          if(response!=null&&response!='[]'){
            setState(() {
              orders_list=json.decode(response);
              if(orders_list!=null&&orders_list.length>0) {
                isVisible = true;
                filteredList.addAll(orders_list);
              }
            });
          }else{
            setState(() {
              isVisible=false;
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: ListView.builder(itemCount: filteredList!=null?filteredList.length:temp.length,itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(filteredList[index]['salesIdField']),
                    trailing:  Text(filteredList[index]['deliveryDateField']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(filteredList[index]['deliveryDateField'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                    subtitle:  Text((() {
                      if(filteredList[index]['packingSlipNumField']!=null){
                        return 'Qty:'+filteredList[index]['quantityInSQMField'].toString()+' SQM'+'\n'+'Packing Slip:'+filteredList[index]['packingSlipNumField'];
                      }else
                        return 'Qty:'+filteredList[index]['quantityInSQMField'].toString()+' SQM';
                    })()),
                    leading: Material(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.teal.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.local_shipping,size: 30,color: Color(0xFF004c4c),),
                        )
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>DeliveryDetails(filteredList[index])));
                    },
                  ),
                  Divider(),
                ],
              ) ;
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
      filteredList.addAll(orders_list);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      filteredList.clear();
      filteredList.addAll(orders_list);
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
            const Text('Deliveries'),
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
        for(int i=0;i<orders_list.length;i++){
          if(orders_list[i]['salesIdField'].toLowerCase().contains(searchQuery)){
            filteredList.add(orders_list[i]);
          }
        }
      }else{
        filteredList.addAll(orders_list);
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