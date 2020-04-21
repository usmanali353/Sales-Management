import 'package:flutter/material.dart';

class RequestDetails extends StatefulWidget{
  var requestData;

  RequestDetails(this.requestData);

  @override
  State<StatefulWidget> createState() {
    return _RequestDetails(requestData);
  }

}
class _RequestDetails extends State<RequestDetails>{
  var requestData;

  _RequestDetails(this.requestData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Production Request Details"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[

              ListTile(
                title: Text("Request Date"),
                subtitle: Text(requestData['RequestedDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(requestData['RequestedDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
              ),
              Divider(),
              ListTile(
                title: Text("Request Id"),
                subtitle: Text(requestData['ProductionRequestId']!=null?requestData['ProductionRequestId']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Request Status"),
                subtitle: Text(requestData['ProductionStatus']!=null?requestData['ProductionStatus']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Approval Date"),
                subtitle: Text(requestData['ApprovalDate']!=null?requestData['ApprovalDate']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Item Number"),
                subtitle: Text(requestData['ItemNumber']!=null?requestData['ItemNumber']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Item Name"),
                subtitle: Text(requestData['ItemDescription']!=null?requestData['ItemDescription']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Item Size"),
                subtitle: Text(requestData['ItemSize']!=null?requestData['ItemSize']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Quantity Requested"),
                subtitle: Text(requestData['QuantityRequested'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("G1 Quantity Produced"),
                subtitle: Text(requestData['QuantityG1Produced'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("MS Quantity Produced"),
                subtitle: Text(requestData['QuantityMSProduced'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Total Quantity Produced"),
                subtitle: Text(requestData['QuantityProduced'].toString()),
              ),
              Divider(),
            ],
          )

        ],
      ),
    );
  }

}