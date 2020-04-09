import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Network_Operations.dart';
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
      body:
        ListView.builder(itemCount: requests!=null?requests.length:temp.length,itemBuilder: (context,int index){
          return Column(
            children: <Widget>[

              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                closeOnScroll: true,
                actions: <Widget>[
                  IconSlideAction(
                    color: Colors.red,
                    icon: Icons.delete,
                    caption: "Delete",
                    closeOnTap: true,
                    onTap: (){
                      Network_Operations.DeleteProdRequest(requests[index]['ProductionRequestId']).then((response){
                        if(response!=null&&response!=''&&response!='[]'){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text("Request Deleted"),
                          ));
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Request not Deleted"),
                          ));
                        }
                      });
                    },
                  ),
                  IconSlideAction(
                    color: Colors.blue,
                    icon: Icons.edit,
                    caption: "Update",
                    closeOnTap: true,
                    onTap: (){

                    },
                  ),
                ],
                child: ListTile(
                  title: Text(requests[index]['ItemDescription']),
                  subtitle: Text(requests[index]['ItemSize']),
                  leading: Icon(FontAwesomeIcons.industry,size: 30,),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestDetails(requests[index])));
                  },
                ),
              ),
              Divider(),
            ],
          ) ;
        }),
      );

  }

}