import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Customer_Cases/casesList.dart';
import 'package:salesmanagement/PrePicking/PrePickingList.dart';
import 'package:salesmanagement/Production_Plan/PlanList.dart';
import 'package:salesmanagement/Production_Request/RequestList.dart';
import 'package:salesmanagement/Production_Schedule/ScheduleList.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/DeliveriesList.dart';
import 'package:salesmanagement/Sales_Services/SalesOrders/SalesOrdersList.dart';
import 'package:salesmanagement/Sales_Services/Stocks/StocksMainPage.dart';
import 'Network_Operations.dart';
import 'Sales_Services/Invoices/InVoicesList.dart';
import 'Utils.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var caseNumbers,caseCardsVisible=false,productionRequestCardVisible=false,productionRequestNumbers,deliveryCardVisible=false,deliveryNumber,weeklyDeliveryCardVisible=false,weeklyDelivery,financeCardVisible=false,finance,totalOnhandStock=0.0,onhandVisible=false;
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
              deliveryCardVisible=true;
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
        Network_Operations.GetDeliveryInDatesSummary("LC0001","2018-10-01","2018-10-02").then((response){
          if(response!=null&&response!='[]'){
            setState(() {
              weeklyDelivery=jsonDecode(response);
                  weeklyDeliveryCardVisible=true;
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
               productionRequestCardVisible=true;
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
              caseCardsVisible=true;
            });
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
           child: Column(
             children: <Widget>[
             Container(
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: GradientColors.beautifulGreen,
                  )),
             alignment: Alignment.topCenter,
               child: DrawerHeader(
                 child:  Image.asset("assets/AC.png",width: 200,height: 200,),
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
                       title: Text("Stocks"),
                       leading: Icon(FontAwesomeIcons.pallet),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>StocksMainPage()));
                       },
                     ),
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
      appBar: AppBar(title: Text("Dashboard"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              //Deliveries
              Visibility(
                visible: deliveryCardVisible,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Deliveries",style: TextStyle(fontSize: 18),),
                ),
              ),
              Wrap(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryList("2019-05-15","LC0001")));
                    },
                    child: Visibility(
                      visible: deliveryCardVisible,
                      child: Card(
                        color: Colors.blue,
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Today's Deliveries (In SQM)"),
                              Text(
                               deliveryNumber!=null?deliveryNumber[0]['quantityField'].toString():'0',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SalesOrdersList('2018-10-01','2018-10-02',"LC0001",'Week Deliveries')));
                    },
                    child: Visibility(
                      visible: weeklyDeliveryCardVisible,
                      child: Card(
                        color: Colors.orange,
                      elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Week's Deliveries (In SQM)"),
                              Text(
                                weeklyDelivery!=null?weeklyDelivery[0]['quantityField'].toString():'0',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //Production Request
              Visibility(
                visible: productionRequestCardVisible,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Production Requests",style: TextStyle(fontSize: 18)),
                ),
              ),
              Visibility(
                visible: productionRequestCardVisible,
                child: Wrap(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.radish,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Requested (In SQM)"),
                              Text(
                               productionRequestNumbers!=null?productionRequestNumbers[0]['OtherValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.ver,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Approved for Production"),
                              Text(
                                productionRequestNumbers!=null?productionRequestNumbers[3]['OtherValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestList('All','LC0001',null,null)));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width - 24),
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.skyLine,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Total Produced (In SQM)"),
                              Text(
                                productionRequestNumbers!=null?productionRequestNumbers[4]['OtherValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Finance
              Visibility(
                visible: financeCardVisible,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child:  Text("Finance",style: TextStyle(fontSize: 18),)
                ),
              ),
              Visibility(
                visible: financeCardVisible,
                child:  InkWell(
                  onTap: (){
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 24),
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: GradientColors.skyLine,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Customer Balance Amount"),
                          Text(
                            finance??'',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //Products
              Visibility(
                visible: caseCardsVisible,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Products",style: TextStyle(fontSize: 18)),
                ),
              ),
              Visibility(
                visible: onhandVisible,
                child: Wrap(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList("LC0001","Opened","Opened Cases")));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.radish,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("On hand Stock (In SQM)"),
                              Text(
                                totalOnhandStock.toString()??'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList("LC0001","In Process","In Process Cases")));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.lightGreen,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Older Stock (In SQM)"),
                              Text(
                                caseNumbers!=null?caseNumbers[1]['SummaryValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Customer Cases
              Visibility(
                visible: caseCardsVisible,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Customer Complaints",style: TextStyle(fontSize: 18)),
                ),
              ),
              Visibility(
                visible: caseCardsVisible,
                child: Wrap(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>casesList("LC0001","Opened","Opened Cases")));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.radish,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Opened"),
                              Text(
                               caseNumbers!=null?caseNumbers[0]['SummaryValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                          width: (MediaQuery.of(context).size.width * 0.5) - 16,
                          height: 100,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: GradientColors.lightGreen,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("In process"),
                              Text(
                               caseNumbers!=null?caseNumbers[1]['SummaryValue'].toString():'',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
          )
        ],
      ),
    );
  }
}
