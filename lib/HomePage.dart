import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Customer_Cases/findCases.dart';
import 'package:salesmanagement/Production_Request/ViewProductionRequests.dart';
import 'package:salesmanagement/Production_Schedule/ViewProductionSchedule.dart';
import 'Production_Plan/GetPlanByYear.dart';
import 'Sales_Services/Deliveries/GetDeliveries.dart';
import 'Sales_Services/Invoices/GetInVoices.dart';
import 'Sales_Services/Products/GetProductBySizeOrModel.dart';
import 'Sales_Services/Products/GetProductInfo.dart';
import 'Sales_Services/SalesOrders/Find_Orders.dart';
import 'Sales_Services/SalesOrders/GetSalesOrder.dart';
import 'Sales_Services/Stocks/GetItemStock.dart';
import 'Sales_Services/Stocks/GetStock.dart';
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
                    title: Text("Find Sales Orders"),
                    subtitle: Text("Get Sales Order(s) for a specific customer between two dates"),
                    leading: Icon(Icons.search,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetSalesOrders()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Deliveries"),
                   subtitle: Text("Gets all the deliveries for a specific customer on a given date"),
                    leading: Icon(Icons.local_shipping,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetDeliveries()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Items stock"),
                   subtitle: Text("Get OnHand stock of specific customer Which is Finished Available or Old"),
                    leading: Icon(FontAwesomeIcons.pallet,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetStock()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Invoices"),
                   subtitle: Text("Get all specific customer’s sales invoices by Customer Id"),
                    leading: Icon(FontAwesomeIcons.fileInvoice,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetInVoices()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Product Info"),
                   subtitle: Text("Get product information searched by Model Size or Item Number"),
                    leading: Icon(FontAwesomeIcons.infoCircle,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetProductInfo()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Customer Cases"),
                    subtitle: Text("Get one or more Customer Cases searched by description or Case Id"),
                    leading: Icon(FontAwesomeIcons.angry,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FindCases()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Customer Plans"),
                   subtitle: Text("Get Yearly and Monthly customer plans for specified Item Sizes"),
                    leading: Icon(FontAwesomeIcons.tasks,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPlanByYear()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Requests"),
                    subtitle: Text("Get production request records for the specific customer"),
                    leading: Icon(FontAwesomeIcons.industry,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProductionRequests()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Production Schedule"),
                    subtitle: Text("Get Production Schedule records for a specific customer"),
                    leading: Icon(FontAwesomeIcons.calendar,size: 30,),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProductionSchedule()));
                    },
                  ),
                  Divider(),
                ],
              )
    );
  }
}