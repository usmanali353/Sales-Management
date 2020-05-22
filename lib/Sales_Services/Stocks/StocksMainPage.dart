import 'package:flutter/material.dart';
import 'package:salesmanagement/Sales_Services/Stocks/StockItemsList.dart';
class StocksMainPage extends StatefulWidget {
  @override
  _StocksMainPageState createState() => _StocksMainPageState();
}

class _StocksMainPageState extends State<StocksMainPage> {
  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(title: Text("Customer Stocks"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Available Stock",),
                Tab(text: "Finished Stock",),
                Tab(text: "Older Stock",),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              StockItemsList('Available Stock','LC0001'),
              StockItemsList('Finished Stock','LC0001'),
              StockItemsList('Older Stock','LC0001'),
            ],
          ),
        )
    );
  }
}
