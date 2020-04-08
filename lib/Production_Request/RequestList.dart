import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Production_Request/RequestDetails.dart';

class RequestList extends StatefulWidget {
  var requests;

  RequestList(this.requests);

  @override
  State<StatefulWidget> createState() {
    return _RequestsList(requests);
  }
}
class _RequestsList extends State<RequestList>{
  var requests,temp=['',''];
  _RequestsList(this.requests);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Production Requests"),),
      body: ListView.builder(itemCount: requests!=null?requests.length:temp.length,itemBuilder: (context,int index){
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(requests[index]['ItemDescription']),
              subtitle: Text(requests[index]['ItemSize']),
              leading: Icon(FontAwesomeIcons.industry,size: 30,),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestDetails(requests[index])));
              },
            ),
            Divider(),
          ],
        ) ;
      }),
    );
  }

}