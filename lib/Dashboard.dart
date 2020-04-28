import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
                    color: Colors.blue,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
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
                    color: Colors.orange,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Week's Deliveries"),
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
                    color: Colors.red,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Requested"),
                          Text(
                            '5',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Approved"),
                          Text(
                            '10',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.cyan,
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 24),
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("All Production Requests"),
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
                    color: Colors.red,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
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
                    color: Colors.green,
                    child: Container(
                      width: (MediaQuery.of(context).size.width * 0.5) - 16,
                      height: 100,
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
                    color: Colors.cyan,
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 24),
                      height: 100,
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
