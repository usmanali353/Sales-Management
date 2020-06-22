import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddPrePicking.dart';
import 'package:salesmanagement/PrePicking/AddProducts.dart';
import 'package:salesmanagement/PrePicking/UpdatePrePicking.dart';
import 'PrePickingDetails.dart';

import '../Utils.dart';
class PrePickingList extends StatefulWidget {
  var customerId;

  PrePickingList(this.customerId);

  @override
  _PrePickingListState createState() => _PrePickingListState(customerId);
}

class _PrePickingListState extends ResumableState<PrePickingList> {
  var prePicking,isVisible=false,customerId,searchQuery = "Search query",_isSearching=false,filteredList=[];
  TextEditingController _searchQuery;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  _PrePickingListState(this.customerId);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  void onResume() {
    print("Data "+resume.data.toString());
    if(resume.data.toString()=='Refresh') {
      WidgetsBinding.instance
          .addPostFrameCallback((_) =>
          _refreshIndicatorKey.currentState
              .show());
    }
  }
  @override
  void initState() {
    _searchQuery=TextEditingController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>
        _refreshIndicatorKey.currentState
            .show());
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         push(context, MaterialPageRoute(builder: (context)=>AddProducts(customerId)));
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
             if(connected){
               ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
               pd.show();
               try{
                 Network_Operations.GetAllPrePicking(customerId).then((response){
                   pd.dismiss();
                   if(response!=null){
                     setState(() {
                       if(prePicking!=null){
                         prePicking.clear();
                       }
                       this.prePicking=jsonDecode(response);
                       if(prePicking!=null&&prePicking.length>0) {
                         if(filteredList!=null){
                           filteredList.clear();
                         }
                         this.filteredList.addAll(prePicking);
                         this.isVisible = true;
                       }
                     });
                   }
                 });
               }catch(e){
                pd.dismiss();
               }
             }else{
               Flushbar(
                 message: "Network not Available",
                 backgroundColor: Colors.red,
                 duration: Duration(seconds: 5),
               )..show(context);
             }
          });
        },
        child: Visibility(
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
                            Network_Operations.DeletePrePicking(filteredList[index]['PickingId']).then((response){
                              if(response!=null&&response!=''&&response!='[]'){
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) =>
                                    _refreshIndicatorKey.currentState
                                        .show());
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("PrePicking Deleted"),
                                ));
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("PrePicking not Deleted"),
                                ));
                              }
                            });
                          },
                        ),
                        IconSlideAction(
                          color: Colors.blue,
                          icon: Icons.edit,
                          caption: "Update",
                          closeOnTap: true,
                          onTap: (){
                            push(context, MaterialPageRoute(builder: (context)=>UpdatePrePicking(filteredList[index])));
                          },
                        ),
                      ],
                      child: ListTile(
                        title: Text(filteredList!=null?filteredList[index]['PickingId']:''),
                        subtitle: Text(filteredList!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(filteredList[index]['DeliveryDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                        trailing: Text(filteredList!=null?getStatus(filteredList[index]['Status']):''),
                        leading:  Material(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.teal.shade100,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10,bottom: 15,right: 18,left: 10),
                              child: Icon(FontAwesomeIcons.truckLoading,size: 30,color: Color(0xFF004c4c),),
                            )
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PrePickingDetails(prePicking[index])));
                        },
                      ),
                    ),
                    Divider(),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
  String getStatus(int status){
    String statusstr;
    if(status==0){
      statusstr="New Request";
    }else if(status==1){
      statusstr="Submitted";
    }else if(status==2){
      statusstr="Approved";
    }else if(status==3){
      statusstr="Rejected";
    }else {
      statusstr="Generate Picking List";
    }
    return statusstr;
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
      filteredList.addAll(prePicking);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      filteredList.clear();
      filteredList.addAll(prePicking);
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
            const Text('Sales Orders'),
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
        for(int i=0;i<prePicking.length;i++){
          if(prePicking[i]['PickingId'].toLowerCase().contains(searchQuery)||prePicking[i]['SalesID'].toLowerCase().contains(searchQuery)){
            filteredList.add(prePicking[i]);
          }
        }
      }else{
        filteredList.addAll(prePicking);
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
