import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:acmc_customer/Model/Deliveries.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/DeliveryLines.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../Utils.dart';
class trackDeliveries extends StatefulWidget {
  Deliveries delivery;

  trackDeliveries(this.delivery);

  @override
  _trackDeliveriesState createState() => _trackDeliveriesState();
}

class _trackDeliveriesState extends State<trackDeliveries> {
   Deliveries delivery;
   bool isVisible=false;
   double sum=0.0;
  @override
  void initState() {
    Utils.check_connectivity().then((isConnected){
      if(isConnected){
        if(widget.delivery!=null&&widget.delivery.pickingIdField!=null){
          print(widget.delivery.pickingIdField);
          Network_Operations.getDeliveryByPickingId(context,widget.delivery.pickingIdField).then((deliveryByPickingId){
            setState(() {

              if(deliveryByPickingId!=null) {
                delivery=deliveryByPickingId;
                isVisible=true;
                for(int i=0;i<delivery.deliveryItemsField.length;i++){
                  sum+=delivery.deliveryItemsField[i].reservedQtyField;
                }
                print(sum/double.parse(delivery.quantityInSqmField.replaceAll(",",""))*100);
              }else{
                isVisible=false;
                Utils.showError(context,"No Delivery Data Found against this Picking Id");
              }
            });
          });
        }
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
         delivery!=null?InkWell(
            onTap: (){

              Navigator.push(context,MaterialPageRoute(builder:(context)=>DeliveryLines(delivery)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("View Lines")),
            ),
          ):Container()
        ],
      ),
      body: Visibility(
        visible: isVisible,
        child: Padding(
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
                        child: Text(delivery!=null&&delivery.packingSlipGenerateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.packingSlipGenerateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
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
                                subtitle: Text(delivery!=null&&delivery.pickingIdField!=null?delivery.pickingIdField:''),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text("Generation Date"),
                                subtitle: Text(delivery!=null&&delivery.packingSlipGenerateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.packingSlipGenerateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
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
                        child: Text(delivery!=null&&delivery.deliveryDateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.deliveryDateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
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
                                    subtitle: Text(delivery!=null&&delivery.truckDriverField!=null?delivery.truckDriverField:''),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("Truck Number"),
                                    subtitle: Text(delivery!=null&&delivery.truckPlateNumField!=null?delivery.truckPlateNumField:''),
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
                                    subtitle: Text(delivery!=null&&delivery.mobileField!=null?delivery.mobileField:''),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("Ticket No."),
                                    subtitle: Text(delivery!=null&&delivery.ticketField!=null?delivery.ticketField:''),
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
                        child: Text(delivery!=null&&delivery.startLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.startLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():'',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
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
                                  currentValue:delivery!=null?(sum/double.parse(delivery.quantityInSqmField.replaceAll(",",""))*100).round():0,
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
                                    subtitle: Text(delivery!=null&&delivery.startLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.startLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("End Loading"),
                                    subtitle: Text(delivery!=null&&delivery.stopLoadTruckField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(delivery.stopLoadTruckField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString():''),
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
                                    subtitle: Text(delivery!=null&&delivery.packingSlipNumField!=null?delivery.packingSlipNumField:''),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("Quantity in SQM"),
                                    subtitle: Text(delivery!=null&&delivery.quantityInSqmField!=null?delivery.quantityInSqmField:''),
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
      ),
    );
  }
}
