import 'package:flutter/material.dart';
import 'package:salesmanagement/Find_Orders.dart';
import 'package:salesmanagement/GetDeliveries.dart';
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
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFa2ffff)])     ),
        child: ListView(
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.all(16),
                      child: ListTile(
                        title: Text("Get Sales Orders"),
                        subtitle: Text("Get Sales Order(s) for a specific customer between two dates"),
                        leading: Icon(Icons.developer_board,size: 40,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GetSalesOrders()));
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:EdgeInsets.only(left: 16,right: 16),
                      child: ListTile(
                        title: Text("Find Sales Orders"),
                        subtitle: Text("Get a single Sales order by specifying a Sales Id number"),
                        leading: Icon(Icons.search,size: 40,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>FindOrders()));
                        },
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:EdgeInsets.only(top:16,left: 16,right: 16),
                      child: ListTile(
                        title: Text("Get Deliveries"),
                        subtitle: Text("Gets all the deliveries for a specific customer on a given date"),
                        leading: Icon(Icons.local_shipping,size: 40,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GetDeliveries()));
                        },
                      ),
                    ),
                  ],
                ),
      )
    );
  }

}