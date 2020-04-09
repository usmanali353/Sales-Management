import 'package:flutter/material.dart';

class CaseDetail extends StatefulWidget{
  var caseData;

  CaseDetail(this.caseData);

  @override
  State<StatefulWidget> createState() {
    return _CaseDetail(caseData);
  }

}
class _CaseDetail extends State<CaseDetail>{
  var caseData;

  _CaseDetail(this.caseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Case Detail"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Case Id"),
                subtitle: Text(caseData['caseIdField']!=null?caseData['caseIdField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Case type"),
                subtitle: Text(caseData['categoryRecIdField']['caseCategoryField']!=null?caseData['categoryRecIdField']['caseCategoryField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Case Description"),
                subtitle: Text(caseData['descriptionField']!=null?caseData['descriptionField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Department"),
                subtitle: Text(caseData['departmentField']!=null?caseData['departmentField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Case Priority"),
                subtitle: Text(caseData['priorityField']!=null?caseData['priorityField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Ower/Worker"),
                subtitle: Text(caseData['ownerWorkerField']!=null?caseData['ownerWorkerField']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Party"),
                subtitle: Text(caseData['partyField']!=null?caseData['partyField']:''),
              ),
              Divider(),
            ],
          )

        ],
      ),
    );
  }

}