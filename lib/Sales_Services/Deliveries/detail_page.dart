import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatefulWidget {
  var orders_data;

  DetailPage(this.orders_data);

  @override
  _DetailPageState createState() => _DetailPageState(orders_data);
}

class _DetailPageState extends State<DetailPage>{
 var orders_data;

 _DetailPageState(this.orders_data);

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
        ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFF004c4c),
            height: 270,
            width: MediaQuery.of(context).size.width,
          ),
//            new Image.asset(
//              'assets/images/bg.png',
//              fit: BoxFit.cover,
//            ),
          Center(
            child:  Card(
              elevation: 6.0,
              margin: EdgeInsets.only(right: 6.0, left: 6.0),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 2, right: 2 ),
                            child: Column(
                              children: <Widget>[
                                Text("Packing Slip#",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                ),
                                Text(orders_data['packingSlipNumField']!=null?orders_data['packingSlipNumField']:'',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Text("Pallet Quantity",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                ),
                                Text(orders_data['quantityInPalletsField']!=null?orders_data['quantityInPalletsField'].toString():'',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Text("Quantity In SQM",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 17
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                ),
                                Text(orders_data['quantityInSQMField']!=null?orders_data['quantityInSQMField'].toString():'',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 2, right: 2 ),
                          child: Column(
                            children: <Widget>[
                              Text("Truck Driver",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                              ),
                              Text(orders_data['truckDriverField']!=null?orders_data['truckDriverField']:'',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Truck Number",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                              ),
                              Text(orders_data['truckPlateNumField']!=null?orders_data['truckPlateNumField']:'',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF004c4c),
                        borderRadius: BorderRadius.circular(8.5),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.date_range, color: Colors.white,size:45),
                        title: Text("Delivery Date", style: TextStyle(
                            color: Colors.white,
                          fontWeight: FontWeight.bold

                        ),
                        ) ,
                        subtitle:Text(orders_data['deliveryDateField']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_data['deliveryDateField'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:'', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        ) ,
                      ),

                    ),
                  )
                ],
              ),
            ),
          ),
//            new RaisedButton(
//              onPressed: () {
//                print('Login Pressed');
//              },
//              color: Colors.redAccent,
//              shape: new RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(30.0)),
//              child: new Text('Login',
//                  style: new TextStyle(
//                      color: Colors.white,
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.bold)),
//            ),
        ],
      ));

  }

}

