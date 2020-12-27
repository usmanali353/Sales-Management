import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/TrackPalletPage.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/trackDeliveryList.dart';
import 'package:acmc_customer/Sales_Services/Invoices/InVoicesList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Customer_Cases/casesList.dart';
import 'Network_Operations.dart';
import 'PrePicking/PrePickingList.dart';
import 'Production_Plan/PlanList.dart';
import 'Production_Request/RequestList.dart';
import 'Production_Schedule/ScheduleList.dart';
import 'Sales_Services/Deliveries/DeliveriesList.dart';
import 'Sales_Services/SalesOrders/SalesOrdersList.dart';
import 'Sales_Services/Stocks/StockItemsList.dart';
import 'Utils.dart';

class newdashboard extends StatefulWidget{
  var customerId;

  newdashboard(this.customerId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _newdashboard(customerId);
  }

}

class _newdashboard extends ResumableState<newdashboard>{
  var todayDeliveryCardVisible=false,weeklyDeliveryCardVisible=false,prodRequestCardVisible=false,financeVisible=false,totalOlderStock=0.0,olderstockVisible=false,currentTheme=false,customerId;
   GlobalKey<RefreshIndicatorState> refreshIndicatorKey=GlobalKey();
  _newdashboard(this.customerId);
  var caseNumbers,caseCardsVisible=false,productionRequestCardVisible=false,productionRequestNumbers,deliveryCardVisible=false,deliveryNumber,weeklyDelivery,financeCardVisible=false,finance,totalOnhandStock=0.0,onhandVisible=false;
  List<double> onHandValues=[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => refreshIndicatorKey.currentState.show());
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
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    title: Text("Track Deliveries"),
                    leading: Icon(FontAwesomeIcons.truckLoading),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>trackDeliveryList("2019-09-15", customerId)));
                    },
                  ),
                  ListTile(
                    title: Text("Track Pallet"),
                    leading: Icon(FontAwesomeIcons.pallet),
                    onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>TrackPalletPage()));
                    },
                  ),
                  ListTile(
                    title: Text("Production Plan"),
                    leading: Icon(FontAwesomeIcons.tasks),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PlanList("All",'2020',null,null,customerId)));
                    },
                  ),
                  ListTile(
                    title: Text("Production Order"),
                    leading: Icon(FontAwesomeIcons.calendar),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SchedulesList(customerId,null)));
                    },
                  ),
                  ListTile(
                    title: Text("Stock Delivery"),
                    leading: Icon(FontAwesomeIcons.truckLoading),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PrePickingList(customerId)));
                    },
                  ),
                  ListTile(
                    title: Text("Finance"),
                    leading: Icon(FontAwesomeIcons.dollarSign),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoicesList(customerId)));
                    },
                  ),
                  ListTile(
                    title: Text("Inventory"),
                    leading: Icon(FontAwesomeIcons.boxes),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemsList('Available Stock',customerId)));
                    },
                  ),
                  ListTile(
                    title: Text("Complaints & Inquiries"),
                    leading: Icon(FontAwesomeIcons.exclamationTriangle),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList(customerId,'All','Complaints & Inquiries')));
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
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
                Network_Operations.GetDeliveryDailySummary(context,customerId,DateFormat("yyyy-MM-dd").format(DateTime.now())).then((response){
                  setState(() {
                    deliveryNumber=jsonDecode(response);
                    this.todayDeliveryCardVisible=true;
                  });
                });
                Network_Operations.GetCustomerOlderStockDashboard(context,customerId).then((response){
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
                Network_Operations.GetDeliveryInDatesSummary(context,customerId,DateFormat("yyyy-MM-dd").format(DateTime.now()),DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 7)))).then((response){
                  setState(() {
                    weeklyDelivery=jsonDecode(response);
                    this.weeklyDeliveryCardVisible=true;
                  });
                });
                Network_Operations.GetOnhandStock(context,customerId).then((response){
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
                Network_Operations.getProductionRequestsSummary(context,customerId).then((response){
                  if(response!=null){
                    setState(() {
                      productionRequestNumbers=jsonDecode(response);
                      this.prodRequestCardVisible=true;
                    });
                  }
                });
                Network_Operations.GetCustomerBalanceOnhand(context,customerId).then((response){
                  if(response!=null){
                    setState(() {
                      this.financeCardVisible=true;
                      this.finance=response;
                    });
                  }
                });

                Network_Operations.getCasesSummary(context,customerId).then((response){
                  if(response!=null){
                    setState(() {
                      caseNumbers=jsonDecode(response);
                      this.caseCardsVisible=true;
                    });
                  }
                });
                SharedPreferences.getInstance().then((prefs){
                  setState(() {
                    if(prefs.getBool("DarkMode")!=null)
                      this.currentTheme=prefs.getBool("DarkMode");
                  });
                });
            }else{
              Flushbar(
                message: "Network not Available",
                duration: Duration(seconds: 5),
                backgroundColor: Colors.red,
              )..show(context);
            }
          });
        },
        child: Container(
          width:MediaQuery.of(context).size.width,
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
                    child: Visibility(
                      visible: todayDeliveryCardVisible||weeklyDeliveryCardVisible,
                      child: Text("Deliveries", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                    )
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
                        //DateFormat("yyyy-MM-dd").format(DateTime.now()
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryList(DateFormat("yyyy-MM-dd").format(DateTime.now()),customerId)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          //width: 185,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("Today's (m\u00B2)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(deliveryNumber!=null&&deliveryNumber.length>0?deliveryNumber[0]['quantityField'].toString():'0', style: TextStyle(color:Color(0xFF004c4c),

                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesOrdersList(DateFormat("yyyy-MM-dd").format(DateTime.now()),DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 30))),customerId,DateFormat.MMMM().format(DateTime.now()).toString()+' Deliveries')));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
                          //width: MediaQuery.of(context).size.width /2.2 ,
                          //width: 185,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.only(left: 12),
                                child: Text(DateFormat.MMMM().format(DateTime.now()).toString()+' (m\u00B2)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(left: 5, right: 5),

                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(weeklyDelivery!=null&&weeklyDelivery.length>0?weeklyDelivery[0]['quantityField'].toString():'0',
                                      style: TextStyle(
                                          color:Colors.teal.shade800,
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
              Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Visibility(
                visible: prodRequestCardVisible,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(null,null,customerId)));
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
                              width: MediaQuery.of(context).size.width *0.35,
                              //width: 145,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                                color: !currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Text(productionRequestNumbers!=null&&productionRequestNumbers.length>4?productionRequestNumbers[4]['OtherValue'].toString():'0',
                                  style: TextStyle(
                                      color:!currentTheme?Colors.white:Colors.teal.shade800,
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
                  child: Visibility(
                    visible: prodRequestCardVisible,
                    child: Text("Production Requests", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  )
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(null,null,customerId)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.only(left: 7),
                                child: Text("Requested (m\u00B2)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
//                            Padding(
//                              padding: EdgeInsets.all(2),
//                            ),
                              Container(

                                //padding: EdgeInsets.only(left: 15, right: 15),
                                margin: EdgeInsets.only(left: 5, right: 5),
                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                  ),

                                  color:!currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(productionRequestNumbers!=null&&productionRequestNumbers.length>0?productionRequestNumbers[0]['OtherValue'].toString():'0',
                                      style: TextStyle(
                                          color:currentTheme?Color(0xFF004c4c):Colors.white,
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(null,null,customerId)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("Approved Production",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    color: !currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(productionRequestNumbers!=null&&productionRequestNumbers.length>3?productionRequestNumbers[3]['OtherValue'].toString():'0',
                                      style: TextStyle(
                                          color:currentTheme?Color(0xFF004c4c):Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList(null,null,customerId)));
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
                              width: MediaQuery.of(context).size.width *0.35,
                              decoration: BoxDecoration(

                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                ),
                                color: !currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Text(productionRequestNumbers!=null&&productionRequestNumbers.length>4?productionRequestNumbers[4]['OtherValue'].toString():'0',
                                  style: TextStyle(
                                      color:currentTheme?Colors.teal.shade800:Colors.white,
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
                  child: Visibility(
                    visible: financeCardVisible,
                    child: Text("Finance", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
              ),
              //Finance
              Visibility(
                visible: financeCardVisible,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoicesList(customerId)));
                    },
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
                            child: Text("Balance Amount",
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
                              width: MediaQuery.of(context).size.width *0.35,

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
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 17),
                      child: Visibility(
                        visible: onhandVisible,
                        child: Text("Inventory", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      )
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
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemsList('Available Stock',customerId)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("On-Hand Stock (m\u00B2)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),

                                //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                                height: 30,
                                width:145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    color: !currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(totalOnhandStock.toStringAsFixed(2).toString()??'0',
                                      style: TextStyle(
                                          color:currentTheme?Color(0xFF004c4c):Colors.white,
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
                  Visibility(
                    visible: olderstockVisible,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemsList('Older Stock',customerId)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //OnHand Stock
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("Old Stock (m\u00B2)",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              //Older Stock
                              Container(
                                //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                                margin: EdgeInsets.only(left: 5, right: 5),
                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

                                    color: !currentTheme?Color(0xFF004c4c):Colors.grey.shade200,
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
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(totalOlderStock!=null?totalOlderStock.toStringAsFixed(2).toString():'0.0',
                                      style: TextStyle(
                                          color:currentTheme?Color(0xFF004c4c):Colors.white,
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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

                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 17),
                      child: Visibility(
                        visible: caseCardsVisible,
                        child: Text("Complaints & Inquiries", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      )
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList(customerId,"Opened","Opened Cases")));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("Opened",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold


                                  ),
                                ),
                              ),
                              Container(
                                //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                                margin: EdgeInsets.only(left: 5, right: 5),

                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),

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
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5),
                                    child: Text(caseNumbers!=null&&caseNumbers.length>0?caseNumbers[0]['SummaryValue'].toString():'0',
                                      style: TextStyle(
                                          color:Color(0xFF9B3340),
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList(customerId,"In Process","In Process Cases")));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 130,
                          width: MediaQuery.of(context).size.width * 0.45 ,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                //margin: EdgeInsets.only(left: 5, right: 5),
                                //margin: EdgeInsets.only(left: 12),
                                child: Text("In-process",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),

                                //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),
                                height: 30,
                                width: 145,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(
                                  child: Container(
                                    //margin: EdgeInsets.only(left: 10,top: 5, bottom: 5),
                                    child: Text(caseNumbers!=null&&caseNumbers.length>1?caseNumbers[1]['SummaryValue'].toString():'0',
                                      style: TextStyle(
                                          color:Color(0xFF004c4c),
                                          //Color(0xFF004c4c),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),

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
      ),
    );
  }
}