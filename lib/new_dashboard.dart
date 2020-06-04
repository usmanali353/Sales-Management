import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/SettingPage.dart';
import 'Customer_Cases/casesList.dart';
import 'Network_Operations.dart';
import 'PrePicking/PrePickingList.dart';
import 'Production_Plan/PlanList.dart';
import 'Production_Request/RequestList.dart';
import 'Production_Schedule/ScheduleList.dart';
import 'Sales_Services/Deliveries/DeliveriesList.dart';
import 'Sales_Services/Invoices/InVoicesList.dart';
import 'Sales_Services/SalesOrders/SalesOrdersList.dart';
import 'Utils.dart';

class newdashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _newdashboard();
  }

}

class _newdashboard extends State<newdashboard>{
  var todayDeliveryCardVisible=false,weeklyDeliveryCardVisible=false,prodRequestCardVisible=false,financeVisible=false,totalOlderStock=0.0,olderstockVisible=false;
  var caseNumbers,caseCardsVisible=false,productionRequestCardVisible=false,productionRequestNumbers,deliveryCardVisible=false,deliveryNumber,weeklyDelivery,financeCardVisible=false,finance,totalOnhandStock=0.0,onhandVisible=false;
  List<double> onHandValues=[];
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.GetDeliveryDailySummary("LC0001","2019-05-15").then((response){
          if(response!=null&&response!='[]'){
            setState(() {
              deliveryNumber=jsonDecode(response);
              this.todayDeliveryCardVisible=true;
            });
          }
        });
//        Network_Operations.GetDeliveryDailySummary("LC0001",DateFormat("yyyy-MM-dd").format(DateTime.now())).then((response){
//          if(response!=null){
//            setState(() {
////              productionRequestNumbers=jsonDecode(response);
////              productionRequestCardVisible=true;
//            });
//          }
//        });
        Network_Operations.GetCustomerOlderStock("LC0001").then((response){
          if(response!=null){
            setState(() {
              var olderStock=jsonDecode(response);
              if(olderStock!=null&&olderStock.length>0){
                this.olderstockVisible=true;
                for(int i=0;i<olderStock.length;i++){
                  totalOlderStock=totalOlderStock+olderStock[i]['QtyAvailablePhysical'];
                }
              }
            });

          }
        });
        Network_Operations.GetDeliveryInDatesSummary("LC0001","2018-10-01","2018-10-02").then((response){
          if(response!=null&&response!='[]'){
            setState(() {
              weeklyDelivery=jsonDecode(response);
              this.weeklyDeliveryCardVisible=true;
            });
          }
        });
        Network_Operations.GetOnhandStock("LC0001").then((response){
          if(response!=null){
            setState(() {
              var onHand=jsonDecode(response);
              this.onhandVisible=true;
              if(onHand!=null){
                for(int i=0;i<onHand.length;i++){
                  onHandValues.add(double.parse(onHand[i]['OnhandALL'].toString()));
                }
                if(onHandValues.length>0){
                  for(int i=0;i<onHandValues.length;i++){
                    totalOnhandStock=totalOnhandStock+onHandValues[i];
                  }
                }
              }
            });
          }
        });
//        Network_Operations.GetDeliveryInDatesSummary("LC0001",DateFormat("yyyy-MM-dd").format(DateTime.now()),DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 7)))).then((response){
//          if(response!=null){
//            setState(() {
////              productionRequestNumbers=jsonDecode(response);
////              productionRequestCardVisible=true;
//            });
//          }
//        });
        Network_Operations.getProductionRequestsSummary("LC0001").then((response){
          if(response!=null){
            setState(() {
              productionRequestNumbers=jsonDecode(response);
              this.prodRequestCardVisible=true;
            });
          }
        });
        Network_Operations.GetCustomerBalanceOnhand("LC0001").then((response){
          if(response!=null){
            setState(() {
              this.financeCardVisible=true;
              this.finance=response;
            });
          }
        });

        Network_Operations.getCasesSummary("LC0001").then((response){
          pd.hide();
          if(response!=null){
            setState(() {
              caseNumbers=jsonDecode(response);
              this.caseCardsVisible=true;
            });
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xEBECF0),
              alignment: Alignment.topCenter,
              child: DrawerHeader(
                child:  Image.asset("assets/img/AC.png",width: 200,height: 200,),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Invoices"),
                    leading: Icon(FontAwesomeIcons.fileInvoice),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoicesList('LC0001')));
                    },
                  ),
                  ListTile(
                    title: Text("Production Plan"),
                    leading: Icon(FontAwesomeIcons.tasks),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanList("All",'2020',null,null,"LC0001")));
                    },
                  ),
                  ListTile(
                    title: Text("Production Schedule"),
                    leading: Icon(FontAwesomeIcons.calendar),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulesList("LC0001")));
                    },
                  ),
                  ListTile(
                    title: Text("Setting"),
                    leading: Icon(Icons.settings),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                    },
                  ),

//                  ListTile(
//                    title: Text("Stocks"),
//                    leading: Icon(FontAwesomeIcons.pallet),
//                    onTap: (){
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=>StocksMainPage()));
//                    },
//                  ),
                  ListTile(
                    title: Text("Pre Picking"),
                    leading: Icon(FontAwesomeIcons.pallet),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrePickingList()));
                    },
                  ),
                ],
              ),
            )
          ],

        ),

      ),
       appBar: AppBar(
        title: Text("Dashboard"),
       ),
      body: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Container(margin: EdgeInsets.only(left: 17),
                  child: Text("Deliveries", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),)
              ),
            ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            //Delivery Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Today Deliveries
                Visibility(
                  visible: todayDeliveryCardVisible,
                  child: InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryList("2019-05-15","LC0001")));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF004c4c),
                            boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("Today's\n(m\u00B2)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                                color: Colors.grey.shade100,
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                                child: Text(deliveryNumber!=null?deliveryNumber[0]['quantityField'].toString():'0', style: TextStyle(color:Color(0xFF004c4c),

                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
               // Weekly Deliveries
                Visibility(
                  visible: weeklyDeliveryCardVisible,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesOrdersList('2018-10-01','2018-10-02',"LC0001",'Week Deliveries')));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFF004c4c),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
//                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("Weekly\n(m\u00B2)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                                color: Colors.grey.shade100,
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                                child: Text(weeklyDelivery!=null?weeklyDelivery[0]['quantityField'].toString():'0',
                                  style: TextStyle(
                                      color:Colors.teal.shade800,
                                      //Color(0xFF004c4c),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  ),
                ),

              ],
            ),
            Visibility(
              visible: prodRequestCardVisible,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right:8.0),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      // margin: EdgeInsets.only(left: 12.5,right: 12.5),
                      height: 130,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.grey.shade400,
//                            offset: Offset(4.0, 4.0),
//                            blurRadius: 15.0,
//                            // spreadRadius: 1.0
//                          ),
//                          BoxShadow(
//                            color: Colors.grey.shade200,
//                            offset: Offset(-4.0, -4.0),
//                            blurRadius: 15.0,
//                            //spreadRadius: 1.0
//                          ),
//                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("Today's Pending (m\u00B2)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),
                              color: Colors.grey.shade200,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey.shade400,
//                                  offset: Offset(4.0, 4.0),
//                                  blurRadius: 15.0,
//                                  // spreadRadius: 1.0
//                                ),
//                                BoxShadow(
//                                  color: Colors.grey.shade100,
//                                  offset: Offset(-4.0, -4.0),
//                                  blurRadius: 15.0,
//                                  //spreadRadius: 1.0
//                                ),
//                              ]
                            ),
                            child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(productionRequestNumbers!=null?productionRequestNumbers[4]['OtherValue'].toString():'0',
                                style: TextStyle(
                                    color:Colors.teal.shade800,
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Container(margin: EdgeInsets.only(left: 17),
                child: Text("Production Request", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),)
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Visibility(
              visible: prodRequestCardVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Status Requested
                  InkWell(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
//                          ]
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("Requested\n(m\u00B2)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),

                                color: Colors.grey.shade200,
//                                  boxShadow: [
//                                    BoxShadow(
//                                      color: Colors.grey.shade400,
//                                      offset: Offset(4.0, 4.0),
//                                      blurRadius: 15.0,
//                                      // spreadRadius: 1.0
//                                    ),
//                                    BoxShadow(
//                                      color: Colors.grey.shade100,
//                                      offset: Offset(-4.0, -4.0),
//                                      blurRadius: 15.0,
//                                      //spreadRadius: 1.0
//                                    ),
//                                  ]
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                                child: Text(productionRequestNumbers!=null?productionRequestNumbers[0]['OtherValue'].toString():'0',
                                  style: TextStyle(
                                      color:Color(0xFF004c4c),
                                      //Color(0xFF004c4c),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  ),
                  //Status Approved for Production
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),

//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
//                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("Approved\nProduction",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)
                                  ),

                                  color: Colors.grey.shade200,
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: Colors.grey.shade400,
//                                    offset: Offset(4.0, 4.0),
//                                    blurRadius: 15.0,
//                                    // spreadRadius: 1.0
//                                  ),
//                                  BoxShadow(
//                                    color: Colors.grey.shade100,
//                                    offset: Offset(-4.0, -4.0),
//                                    blurRadius: 15.0,
//                                    //spreadRadius: 1.0
//                                  ),
//                                ]
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                                child: Text(productionRequestNumbers!=null?productionRequestNumbers[3]['OtherValue'].toString():'0',
                                  style: TextStyle(
                                      color:Color(0xFF004c4c),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
            ),
            //Status Produced
            Visibility(
              visible: prodRequestCardVisible,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right:8.0),
                  child: Card(
                    elevation: 10,
                    child: Container(
                     // margin: EdgeInsets.only(left: 12.5,right: 12.5),
                      height: 130,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
//                        boxShadow: [
//                          BoxShadow(
//                            color: Colors.grey.shade400,
//                            offset: Offset(4.0, 4.0),
//                            blurRadius: 15.0,
//                            // spreadRadius: 1.0
//                          ),
//                          BoxShadow(
//                            color: Colors.grey.shade200,
//                            offset: Offset(-4.0, -4.0),
//                            blurRadius: 15.0,
//                            //spreadRadius: 1.0
//                          ),
//                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("Total Produced (m\u00B2)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),
                              color: Colors.grey.shade200,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey.shade400,
//                                  offset: Offset(4.0, 4.0),
//                                  blurRadius: 15.0,
//                                  // spreadRadius: 1.0
//                                ),
//                                BoxShadow(
//                                  color: Colors.grey.shade100,
//                                  offset: Offset(-4.0, -4.0),
//                                  blurRadius: 15.0,
//                                  //spreadRadius: 1.0
//                                ),
//                              ]
                            ),
                            child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(productionRequestNumbers!=null?productionRequestNumbers[4]['OtherValue'].toString():'0',
                                style: TextStyle(
                                    color:Colors.teal.shade800,
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Container(margin: EdgeInsets.only(left: 17),
                child: Text("Finance", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            //Finance
            Visibility(
              visible: financeCardVisible,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    //margin: EdgeInsets.only(left: 12.5,right: 12.5),
                    height: 130,
                    width: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF004c4c),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.grey.shade400,
//                        offset: Offset(4.0, 4.0),
//                        blurRadius: 15.0,
//                        // spreadRadius: 1.0
//                      ),
//                      BoxShadow(
//                        color: Colors.grey.shade200,
//                        offset: Offset(-4.0, -4.0),
//                        blurRadius: 15.0,
//                        //spreadRadius: 1.0
//                      ),
//                    ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text("Customer Balance Amount",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                            ),
                      ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10),
//                      color: Color(0xFF004c4c),
//                      height: 20,
//                      width: 100,
//                      child: Text("Customer Balance Amount",
//                          style: TextStyle(
//                            color: Colors.white
//                          ),
//                      ),
//                    ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                            ),
                            color: Colors.grey.shade100,
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text( finance??'',
                              style: TextStyle(
                              color:Colors.teal.shade800,
                              //Color(0xFF004c4c),
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),

                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(left: 17),
                    child: Text("Products", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),)
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Visibility(
                  visible: onhandVisible,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 130,
                      width: 185,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),

//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.shade400,
//                          offset: Offset(4.0, 4.0),
//                          blurRadius: 15.0,
//                          // spreadRadius: 1.0
//                        ),
//                        BoxShadow(
//                          color: Colors.grey.shade200,
//                          offset: Offset(-4.0, -4.0),
//                          blurRadius: 15.0,
//                          //spreadRadius: 1.0
//                        ),
//                      ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("On-Hand\nStock\n(m\u00B2)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                            height: 30,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),

                                color: Colors.grey.shade200,
//                            boxShadow: [
//                              BoxShadow(
//                                color: Colors.grey.shade400,
//                                offset: Offset(4.0, 4.0),
//                                blurRadius: 15.0,
//                                // spreadRadius: 1.0
//                              ),
//                              BoxShadow(
//                                color: Colors.grey.shade100,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
//                            ]
                            ),
                            child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(totalOnhandStock.toString()??'0',
                                style: TextStyle(
                                    color:Color(0xFF004c4c),
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          )
                        ],
                      ),

                    ),
                  ),
                ),
                Visibility(
                  visible: olderstockVisible,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 130,
                      width: 185,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.shade400,
//                          offset: Offset(4.0, 4.0),
//                          blurRadius: 15.0,
//                          // spreadRadius: 1.0
//                        ),
//                        BoxShadow(
//                          color: Colors.grey.shade200,
//                          offset: Offset(-4.0, -4.0),
//                          blurRadius: 15.0,
//                          //spreadRadius: 1.0
//                        ),
//                      ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //OnHand Stock
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text("Old Stock\n(m\u00B2)",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          //Older Stock
                          Container(
                            //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                            height: 30,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),

                                color: Colors.grey.shade200,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey.shade400,
//                                  offset: Offset(4.0, 4.0),
//                                  blurRadius: 15.0,
//                                  // spreadRadius: 1.0
//                                ),
//                                BoxShadow(
//                                  color: Colors.grey.shade100,
//                                  offset: Offset(-4.0, -4.0),
//                                  blurRadius: 15.0,
//                                  //spreadRadius: 1.0
//                                ),
//                              ]
                            ),
                            child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                              child: Text(totalOlderStock!=null?totalOlderStock.toString():'0.0',
                                style: TextStyle(
                                    color:Color(0xFF004c4c),
                                    //Color(0xFF004c4c),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(left: 17),
                    child: Text("Customer Complaints", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),)
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),

            Visibility(
              visible: caseCardsVisible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList("LC0001","Opened","Opened Cases")));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF9B3340),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
//                          ]
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("Opened",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold


                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)
                                  ),

                                  color: Colors.grey.shade200,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey.shade400,
//                                  offset: Offset(4.0, 4.0),
//                                  blurRadius: 15.0,
//                                  // spreadRadius: 1.0
//                                ),
//                                BoxShadow(
//                                  color: Colors.grey.shade100,
//                                  offset: Offset(-4.0, -4.0),
//                                  blurRadius: 15.0,
//                                  //spreadRadius: 1.0
//                                ),
//                              ]
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                                child: Text(caseNumbers!=null?caseNumbers[0]['SummaryValue'].toString():'0',
                                  style: TextStyle(
                                      color:Color(0xFF9B3340),
                                      //Color(0xFF004c4c),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList("LC0001","In Process","In Process Cases")));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 130,
                        width: 185,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF004c4c),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.grey.shade400,
//                              offset: Offset(4.0, 4.0),
//                              blurRadius: 15.0,
//                              // spreadRadius: 1.0
//                            ),
//                            BoxShadow(
//                              color: Colors.grey.shade200,
//                              offset: Offset(-4.0, -4.0),
//                              blurRadius: 15.0,
//                              //spreadRadius: 1.0
//                            ),
//                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text("In-process",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                              height: 30,
                              width: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                                color: Colors.grey.shade100,
                              ),
                              child: Container(margin: EdgeInsets.only(left: 10,top: 5, bottom: 5),
                                child: Text(caseNumbers!=null?caseNumbers[1]['SummaryValue'].toString():'0',
                                  style: TextStyle(
                                      color:Color(0xFF004c4c),
                                      //Color(0xFF004c4c),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}