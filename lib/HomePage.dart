import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Find_Orders.dart';
import 'package:salesmanagement/GetDeliveries.dart';
import 'package:salesmanagement/GetStock.dart';
import 'GetSalesOrder.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Get Sales Orders"),
                    subtitle: Text("Get Sales Order(s) for a specific customer between two dates"),
                    leading: Icon(Icons.developer_board,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetSalesOrders()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Find Sales Orders"),
                    subtitle: Text("Get a single Sales order by specifying a Sales Id number"),
                    leading: Icon(Icons.search,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FindOrders()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Get Deliveries"),
                    subtitle: Text("Gets all the deliveries for a specific customer on a given date"),
                    leading: Icon(Icons.local_shipping,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetDeliveries()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Get OnHand stock of a customer"),
                    subtitle: Text("Get OnHand stock those have quantities more than zero"),
                    leading: Icon(FontAwesomeIcons.boxes,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock(false)));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Get OnHand stock of a customer"),
                    subtitle: Text("Get OnHand stock those have quantities equal to zero"),
                    leading: Icon(FontAwesomeIcons.boxes,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock(true)));
                    },
                  ),
                  Divider(),
                ],
              )
    );
  }

}