import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/CaseDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';

class PlanList extends StatefulWidget{
  var planList;

  PlanList(this.planList);

  @override
  State<StatefulWidget> createState() {
    return _PlanList(planList);
  }

}
class _PlanList extends State<PlanList>{
  var planList,temp=['',''],isVisible=false;

  _PlanList(this.planList);
  @override
  void initState() {
    if(planList!=''){
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
        child: ListView.builder(itemCount: planList!=null?planList.length:temp.length,itemBuilder: (context,int index){
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
                        Network_Operations.DeleteCustomerCase(planList[index]['recIdField']).then((response){
                          pd.dismiss();
                          if(response!=null){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Plan Deleted Sucessfully"),
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
                    title: Text(planList[index]['caseIdField']!=null?planList[index]['caseIdField']:''),
                    subtitle: Text(planList[index]['categoryRecIdField']['caseCategoryField']!=null?planList[index]['categoryRecIdField']['caseCategoryField']:''),
                    leading: Icon(FontAwesomeIcons.angry,size: 30,),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>CaseDetail(planList[index])));
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