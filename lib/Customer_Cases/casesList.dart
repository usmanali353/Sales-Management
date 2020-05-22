import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
class _casesList extends State<casesList>{
  var caseListAll=[],customerId,temp=['',''],isVisible=false,caseList=[],caseType,title,_isSearching=false;
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String searchQuery = "Search query";
  TextEditingController _searchQuery;
  _casesList(this.customerId,this.caseType,this.title);
  @override
  void initState() {
    _searchQuery=TextEditingController();
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.FindCustomerCases(customerId).then((response){
          pd.hide();
          if(response!=null&&response!='[]'){
            setState(() {
              isVisible=true;
              caseListAll=jsonDecode(response);
              if(caseType=="Opened"){
                for(int i=0;i<caseListAll.length;i++){
                  print(caseListAll[i]['Status']);
                  if(caseListAll[i]['Status']==1){
                    caseList.add(caseListAll[i]);
                    print(caseList.length.toString());
                  }
                }
              }else if(caseType=="In Process"){
                for(int i=0;i<caseListAll.length;i++){
                  print(caseListAll[i]['Status']);
                  if(caseListAll[i]['Status']==2){
                    caseList.add(caseListAll[i]);
                    print(caseList.length.toString());
                  }
                }
              }else{
                caseList.addAll(caseListAll);
                print(caseList.length.toString());
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCase()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: Visibility(
        visible:isVisible,
        child: ListView.builder(itemCount: caseList!=null?caseList.length:temp.length,itemBuilder: (context,int index){
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
                  ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
                  pd.show();
                  Network_Operations.DeleteCustomerCase(caseList[index]['CaseNum']).then((response){
                    pd.dismiss();
                     if(response!=null){
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
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateCases(caseList[index])));
                },
              ),
            ],
            child: ListTile(
                title: Text(caseList[index]['CaseNum']!=null?caseList[index]['CaseNum']:''),
                subtitle: Text(caseList[index]['Status']!=null?getCaseType(caseList[index]['CategoryTypeId']):''),
                leading: Icon(FontAwesomeIcons.angry,size: 30,),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CaseDetail(caseList[index])));
                },
          )
              ),


              Divider(),
            ],
          ) ;
        }),
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