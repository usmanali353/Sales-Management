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
                    trailing: Text(caseData['CaseNum']!=null?caseData['CaseNum']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case type"),
                    trailing: Text(caseData['CategoryTypeId']!=null?getCaseType(caseData['CategoryTypeId']):''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case Description"),
                    subtitle: Text(caseData['CaseDescription']!=null?caseData['CaseDescription']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Case Priority"),
                    trailing: Text(caseData['Priority']!=null?caseData['Priority']:''),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Resolution Type"),
                    trailing: Text(caseData['ResolutionType']!=null?getResolutionType(caseData['ResolutionType']):''),
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
String getResolutionType(int resolutionType){
   String  restype;
    if(resolutionType==0){
      restype='None';
    }else if(resolutionType==1){
      restype='Accept';
    }else if(resolutionType==2){
      restype='Reject';
    }
    return restype;
}
}