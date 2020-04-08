import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/CaseDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';

class casesList extends StatefulWidget{
  var caseList;

  casesList(this.caseList);

  @override
  State<StatefulWidget> createState() {
    return _casesList(caseList);
  }

}
class _casesList extends State<casesList>{
  var caseList,temp=['',''],isVisible=false;

  _casesList(this.caseList);
  @override
  void initState() {
     if(caseList!=''){
      setState(() {
        isVisible=true;
      });
     }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Cases"),),
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
                  Network_Operations.DeleteCustomerCase(caseList[index]['recIdField']).then((response){
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

                },
              ),
            ],
            child: ListTile(
                title: Text(caseList[index]['caseIdField']!=null?caseList[index]['caseIdField']:''),
                subtitle: Text(caseList[index]['categoryRecIdField']['caseCategoryField']!=null?caseList[index]['categoryRecIdField']['caseCategoryField']:''),
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

}