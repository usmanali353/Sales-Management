import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Model/Deliveries.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/trackDeliveries.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../Utils.dart';
class trackDeliveryList extends StatefulWidget {
  var date,CustomerId;

  trackDeliveryList(this.date, this.CustomerId);

  @override
  _trackDeliveryListState createState() => _trackDeliveryListState();
}

class _trackDeliveryListState extends State<trackDeliveryList> {
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey=GlobalKey();
  List<Deliveries> orders_list=[];
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>
        _refreshIndicatorKey.currentState
            .show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deliveries"),
      ),
      body:RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              Network_Operations.get_deliveries(context,widget.date,widget.CustomerId).then((deliveries){
                if(deliveries!=null&&deliveries.length>0){
                  setState(() {
                    orders_list=deliveries;
                  });
                }
              });
            }
          });
        },
        child: ListView.builder(
          itemCount: orders_list!=null?orders_list.length:0,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>trackDeliveries(orders_list[index])));
                  },
                  child: Container(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.dropbox),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(orders_list[index].packingSlipNumField!=null?orders_list[index].packingSlipNumField:'',style: TextStyle(color: Color(0xFF004c4c),fontWeight: FontWeight.bold,fontSize: 22),),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(Utils.getDeliveryStatus(orders_list[index].deliveryStatusField),style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF004c4c)),),
                                Text(orders_list[index].deliveryDateField!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(orders_list[index].deliveryDateField.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:'')
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text("Sales Order"),
                                  subtitle: Text(orders_list[index].salesIdField!=null?orders_list[index].salesIdField:''),
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF004c4c)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: FaIcon(FontAwesomeIcons.balanceScale,size: 10,color: Color(0xFF004c4c),),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text("Truck No."),
                                  subtitle: Text(orders_list[index].truckPlateNumField!=null?orders_list[index].truckPlateNumField:''),
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF004c4c)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: FaIcon(FontAwesomeIcons.truck,size: 10,color: Color(0xFF004c4c),),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            constraints: const BoxConstraints(maxHeight: 65),
                            // padding: EdgeInsets.only(bottom: 8),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  endChild: Text("Open"),
                                  indicatorStyle: IndicatorStyle(
                                      color:orders_list[index].deliveryStatusField==0?Color(0xFF004c4c):Colors.grey
                                  ),
                                  isFirst: true,
                                ),
                                TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  endChild: Text("In progress"),
                                ),
                                TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  endChild: Text("Completed"),

                                ),
                                TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  endChild: Text("Closed"),
                                  indicatorStyle: IndicatorStyle(
                                      color:orders_list[index].deliveryStatusField==1?Color(0xFF004c4c):Colors.grey
                                  ),
                                ),
                                TimelineTile(
                                  axis: TimelineAxis.horizontal,
                                  alignment: TimelineAlign.center,
                                  endChild: Text("Cancelled"),
                                  isLast: true,
                                  indicatorStyle: IndicatorStyle(
                                      color:orders_list[index].deliveryStatusField==2?Color(0xFF004c4c):Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      )
    );
  }
}
