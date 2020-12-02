import 'package:flutter/material.dart';
import 'package:salesmanagement/Model/CustomerCases.dart';
import 'package:salesmanagement/Utils.dart';

class CaseDetail extends StatefulWidget{
  CustomerCases caseData;

  CaseDetail(this.caseData);

  @override
  State<StatefulWidget> createState() {
    return _CaseDetail(caseData);
  }

}
class _CaseDetail extends State<CaseDetail>{
  CustomerCases caseData;

  _CaseDetail(this.caseData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Case Detail"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Case Id"),
                    trailing: Text(caseData.caseNum!=null?caseData.caseNum:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case type"),
                    trailing: Text(caseData.categoryTypeId!=null?Utils.getCaseType(caseData.categoryTypeId):''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case Description"),
                    subtitle: Text(caseData.caseDescription!=null?caseData.caseDescription:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case Priority"),
                    trailing: Text(caseData.priority!=null?caseData.priority:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Resolution Type"),
                    trailing: Text(caseData.resolutionType!=null?Utils.getResolutionType(caseData.resolutionType):''),
                  ),
                  Divider(),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}