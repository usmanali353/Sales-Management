import 'dart:convert';
import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/CaseDetail.dart';
import 'package:salesmanagement/Customer_Cases/CreateCase.dart';
import 'package:salesmanagement/Customer_Cases/UpdateCases.dart';
import 'package:salesmanagement/Network_Operations.dart';
import '../Utils.dart';

class casesList extends StatefulWidget{
  var customerId,caseType,title;

  casesList(this.customerId,this.caseType,this.title);

  @override
  State<StatefulWidget> createState() {
    return _casesList(customerId,this.caseType,this.title);
  }

}
class _casesList extends ResumableState<casesList>{
  var caseListAll=[],customerId,temp=['',''],isVisible=false,caseList=[],caseType,title,_isSearching=false,filteredList=[];
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = "Search query";
  TextEditingController _searchQuery;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  _casesList(this.customerId,this.caseType,this.title);
  @override
  void initState() {
    _searchQuery=TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
@override
void onResume() {
    if(resume.data.toString()=='Refresh'){
      WidgetsBinding.instance
          .addPostFrameCallback((_) =>
          _refreshIndicatorKey.currentState
              .show());
    }
    super.onResume();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          push(context, MaterialPageRoute(builder: (context)=>CreateCase(customerId)));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Network_Operations.FindCustomerCases(context,customerId).then((response){
                if(response!=null&&response!='[]'){
                  setState(() {
                    isVisible=true;
                    if(caseListAll!=null){
                      caseListAll.clear();
                    }
                    if(caseList!=null){
                      caseList.clear();
                    }
                    caseListAll=jsonDecode(response);
                    if(caseType=="Opened"){
                      for(int i=0;i<caseListAll.length;i++){
                        print(caseListAll[i]['Status']);
                        if(caseListAll[i]['Status']==1){
                          caseList.add(caseListAll[i]);
                          print(caseList.length.toString());
                        }
                      }
                      if(filteredList!=null){
                        filteredList.clear();
                      }
                      filteredList.addAll(caseList);
                    }else if(caseType=="In Process"){
                      if(caseList!=null){
                        caseList.clear();
                      }
                      for(int i=0;i<caseListAll.length;i++){
                        print(caseListAll[i]['Status']);
                        if(caseListAll[i]['Status']==2){
                          caseList.add(caseListAll[i]);
                          print(caseList.length.toString());
                        }
                      }
                      if(filteredList!=null){
                        filteredList.clear();
                      }
                      filteredList.addAll(caseList);
                    }else{
                      if(caseList!=null){
                        caseList.clear();
                      }
                      caseList.addAll(caseListAll);

                      if(filteredList!=null){
                        filteredList.clear();
                      }
                      filteredList.addAll(caseList);
                      print(caseList.length.toString());
                    }
                  });

                }
              });
            }else{
              Flushbar(
                message: "Network Not Available",
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5),
              )..show(context);
            }
          });
        },
        child: Visibility(
          visible:isVisible,
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
                    Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                  actions: <Widget>[
                    IconSlideAction(
                      icon: Icons.delete,
                      color: Colors.red,
                      caption: 'Delete',
                      onTap: (){
                        Network_Operations.DeleteCustomerCase(context,filteredList[index]['CaseNum']).then((response){
                           if(response!=null){
                             WidgetsBinding.instance
                                 .addPostFrameCallback((_) =>
                                 _refreshIndicatorKey.currentState
                                     .show());
                             Scaffold.of(context).showSnackBar(SnackBar(
                               backgroundColor: Colors.green,
                               content: Text("Case Deleted Sucessfully"),
                             ));
                           }
                        });
                      },
                    ),
                    IconSlideAction(
                      icon: Icons.edit,
                      color: Colors.blue,
                      caption: 'Update',
                      onTap: (){
                       push(context, MaterialPageRoute(builder: (context)=>UpdateCases(filteredList[index])));
                      },
                    ),
                  ],
                  child: ListTile(
                      title: Text(filteredList[index]['CaseNum']!=null?filteredList[index]['CaseNum']:''),
                      subtitle: Text(filteredList[index]['Status']!=null?getCaseType(filteredList[index]['CategoryTypeId']):''),
                      leading: Material(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFF9B3340),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            //padding: const EdgeInsets.only(top:11,bottom: 15,right: 10,left: 10),
                            child: Icon(FontAwesomeIcons.exclamation,size: 25,color: Colors.white,),
                          )
                      ),
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>CaseDetail(filteredList[index])));
                      },
                )
                    ),


                    Divider(),
                  ],
                ) ;
              }),
            ),
          ),
        ),
      ),
    );

  }
  String getCaseType(int CategoryTypeId){
    String type;
    if(CategoryTypeId==5637145326){
      type="Inquiry";
    }
    if(CategoryTypeId==5637144576){
      type="Complaint";
    }
    return type;
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
      filteredList.addAll(caseList);
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
      filteredList.clear();
      searchQuery = newQuery;
      if(searchQuery.length>0){
        for(int i=0;i<caseList.length;i++){
          if(caseList[i]['CaseNum'].toLowerCase().contains(searchQuery)){
            filteredList.add(caseList[i]);
          }
        }
      }else{
        filteredList.addAll(caseList);
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