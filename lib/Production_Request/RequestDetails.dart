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
                trailing: Text(requestData['RequestedDate']),
              ),
              Divider(),
              ListTile(
                title: Text("Request Id"),
                trailing: Text(requestData['ProductionRequestId']),
              ),
              Divider(),
              ListTile(
                title: Text("Request Status"),
                trailing: Text(requestData['ProductionStatus']),
              ),
              Divider(),
              ListTile(
                title: Text("Approval Date"),
                trailing: Text(requestData['ApprovalDate']),
              ),
              Divider(),
              ListTile(
                title: Text("Item Number"),
                trailing: Text(requestData['ItemNumber']),
              ),
              Divider(),
              ListTile(
                title: Text("Item Name"),
                trailing: Text(requestData['ItemDescription']),
              ),
              Divider(),
              ListTile(
                title: Text("Item Size"),
                trailing: Text(requestData['ItemSize']),
              ),
              Divider(),
              ListTile(
                title: Text("Quantity Requested"),
                trailing: Text(requestData['QuantityRequested'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("G1 Quantity Produced"),
                trailing: Text(requestData['QuantityG1Produced'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("MS Quantity Produced"),
                trailing: Text(requestData['QuantityMSProduced'].toString()),
              ),
              Divider(),
              ListTile(
                title: Text("Total Quantity Produced"),
                trailing: Text(requestData['QuantityProduced'].toString()),
              ),
              Divider(),
            ],
          )

        ],
      ),
    );
  }

}