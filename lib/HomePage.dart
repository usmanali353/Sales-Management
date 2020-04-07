import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Deliveries/GetDeliveries.dart';
import 'Invoices/GetInVoices.dart';
import 'Products/GetProductBySizeOrModel.dart';
import 'Products/GetProductInfo.dart';
import 'SalesOrders/Find_Orders.dart';
import 'SalesOrders/GetSalesOrder.dart';
import 'Stocks/GetItemStock.dart';
import 'Stocks/GetStock.dart';


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
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Sales Orders"),
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
                    title: Text("Deliveries"),
                    subtitle: Text("Gets all the deliveries for a specific customer on a given date"),
                    leading: Icon(Icons.local_shipping,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetDeliveries()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Available stock of a customer"),
                    subtitle: Text("Get OnHand stock of specific customer those have quantities more than zero"),
                    leading: Icon(FontAwesomeIcons.pallet,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock("Remaining Stock")));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Finished stock of a customer"),
                    subtitle: Text("Get OnHand stock of specific customer those have quantities equal to zero"),
                    leading: Icon(FontAwesomeIcons.boxOpen,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock("Finished Stock")));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Older stock of a customer"),
                    subtitle: Text("Get OnHand stock of specific customer that is atleast one month old"),
                    leading: Icon(FontAwesomeIcons.history,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock("Old Stock")));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Stock of Specific Item"),
                    subtitle: Text("Get onHand quantities for a specific Item by item number"),
                    leading: Icon(FontAwesomeIcons.box,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetItemStock()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Customer Invoices"),
                    subtitle: Text("Get all specific customer’s sales invoices by Customer Id"),
                    leading: Icon(FontAwesomeIcons.fileInvoice,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetInVoices()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Product By Size"),
                    subtitle: Text("Get all the customer’s exclusive products by size "),
                    leading: Icon(FontAwesomeIcons.rulerHorizontal,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductBySizeOrModel(true)));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Product By Model"),
                    subtitle: Text("Get all the customer’s exclusive products by Model "),
                    leading: Icon(FontAwesomeIcons.productHunt,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductBySizeOrModel(false)));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Product Info"),
                    subtitle: Text("Get single product information "),
                    leading: Icon(FontAwesomeIcons.infoCircle,size: 40,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductInfo()));
                    },
                  ),
                  Divider(),
                ],
              )
    );
  }
}