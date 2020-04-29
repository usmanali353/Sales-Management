import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
           child: Column(
             children: <Widget>[
             Container(
             height: 180,
             color: Colors.white,
             alignment: Alignment.topCenter,
               child: DrawerHeader(
                 child:  Image.asset("images/logo.png",width: 200,height: 200,),
               ),
             ),
               ListView(
                 shrinkWrap: true,
                 children: <Widget>[
                   ListTile(
                     title: Text("Invoices"),
                     leading: Icon(FontAwesomeIcons.fileInvoice),
                   ),
                   ListTile(
                     title: Text("Production Schedule"),
                     leading: Icon(FontAwesomeIcons.tasks),
                   ),
                 ],
               )
             ],

           ),

         ),
      appBar: AppBar(title: Text("Dashboard"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Deliveries",style: TextStyle(fontSize: 18),),
              ),
              Wrap(
                children: <Widget>[
                  Card(
                    //color: Colors.blue,
                    elevation: 50,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: GradientColors.blue,
                        )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Today's Deliveries"),
                          Text(
                            '5 Trucks',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    //color: Colors.orange,
                  elevation: 50,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: GradientColors.orange,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Week's Deliveries(In SQM)"),
                          Text(
                            '100 Trucks',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Production Requests",style: TextStyle(fontSize: 18)),
              ),
              Wrap(
                children: <Widget>[
                  Card(
                    elevation: 50,
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
                            '5',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 50,
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
                          Text("Approved (In SQM)"),
                          Text(
                            '10',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 50,
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
                          Text("All Production Requests (In SQM)"),
                          Text(
                            '15',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Customer Complaints",style: TextStyle(fontSize: 18)),
              ),
              Wrap(
                children: <Widget>[
                  Card(
                    elevation: 50,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: GradientColors.coolBlues,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Pending"),
                          Text(
                            '5',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 50,
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
                          Text("Resolved"),
                          Text(
                            '10',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 50,
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 24),
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: GradientColors.purplePink,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("All Complaints"),
                          Text(
                            '15',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
