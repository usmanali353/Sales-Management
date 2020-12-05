import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:salesmanagement/Model/Deliveries.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/DeliveryLines.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../Utils.dart';
class trackDeliveries extends StatefulWidget {
  Deliveries delivery;

  trackDeliveries(this.delivery);

  @override
  _trackDeliveriesState createState() => _trackDeliveriesState();
}

class _trackDeliveriesState extends State<trackDeliveries> {

  @override
  void initState() {
    Utils.check_connectivity().then((isConnected){
      if(isConnected){
        Network_Operations.getDeliveryByPickingId(context,widget.delivery.pickingIdField).then((deliveryByPickingId){
          setState(() {
            if(deliveryByPickingId!=null) {
               widget.delivery=deliveryByPickingId;
            }else{
              Utils.showError(context,"No Delivery Data Found against this Picking Id");
            }
          });
        });
      }else{
        Utils.showError(context,"Network Not Available");
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Deliveries"),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder:(context)=>DeliveryLines(widget.delivery)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("View Lines")),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                  indicatorXY: 0.00
              ),
              isFirst: true,
              endChild: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Text(widget.delivery.packingSlipGenerateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.packingSlipGenerateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8,right: 8,bottom: 8),
                    child: Card(
                      elevation: 10,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("Picking List #"),
                              subtitle: Text(widget.delivery.pickingIdField!=null?widget.delivery.pickingIdField:''),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text("Generation Date"),
                              subtitle: Text(widget.delivery.packingSlipGenerateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.packingSlipGenerateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                  indicatorXY: 0.02
              ),
              endChild: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Text(widget.delivery.deliveryDateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.deliveryDateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom:8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(8),
                              child: Text("Delivery Details",style: TextStyle(color: Colors.teal,fontSize: 18,fontWeight: FontWeight.bold),)
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Truck Driver"),
                                  subtitle: Text(widget.delivery.truckDriverField!=null?widget.delivery.truckDriverField:''),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Truck Number"),
                                  subtitle: Text(widget.delivery.truckPlateNumField!=null?widget.delivery.truckPlateNumField:''),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Driver Mobile"),
                                  subtitle: Text(widget.delivery.mobileField!=null?widget.delivery.mobileField:''),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Ticket No."),
                                  subtitle: Text(widget.delivery.ticketField!=null?widget.delivery.ticketField:''),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                  indicatorXY: 0.05
              ),
              endChild: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Text(widget.delivery.startLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.startLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(8),
                            child: Text("Truck Loading Status",style: TextStyle(color: Colors.teal,fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: FAProgressBar(
                                direction: Axis.horizontal,
                                currentValue: 60,
                                size: 20,
                                border: Border.all(width: 1,color: Colors.grey),
                                progressColor: Color(0xFF004c4c),
                                displayText: "% Loaded",
                                animatedDuration: Duration(seconds: 5),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Start Loading"),
                                  subtitle: Text(widget.delivery.startLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.startLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("End Loading"),
                                  subtitle: Text(widget.delivery.stopLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(widget.delivery.stopLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            TimelineTile(
              indicatorStyle: IndicatorStyle(
                indicatorXY: 0.07
              ),
              isLast: true,
              endChild: Column(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Text("2020-11-11 012:00 AM",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom:8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(8),
                            child: Text("Delivery Notes",style: TextStyle(color: Colors.teal,fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Packing List"),
                                  subtitle: Text(widget.delivery.packingSlipNumField!=null?widget.delivery.packingSlipNumField:''),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Quantity in SQM"),
                                  subtitle: Text(widget.delivery.quantityInSqmField!=null?widget.delivery.quantityInSqmField:''),
                                ),
                              ),
                            ],
                          ),
                        ],

                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
