import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  TextEditingController pickingId,salesOrderId;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  List<Deliveries> orders_list=[];
  @override
  void initState() {
    pickingId=TextEditingController();
    salesOrderId=TextEditingController();
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
        actions: [
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Search by Picking Id'){
                 showSearchByPickingIdDialog(context);
              }else if(choice=='Search by Barcode') {
                Utils.scan(context);
              }else if(choice=="Search by Sales Order"){
                showSearchBySalesOrderDialog(context);
              }
            },
            itemBuilder: (BuildContext context){
              return ['Search by Picking Id','Search by Barcode',"Search by Sales Order"].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },

          )
        ],
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
                                FaIcon(FontAwesomeIcons.dropbox,color: Color(0xFF004c4c),),
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
                                  isFirst: true,
                                  indicatorStyle: IndicatorStyle(
                                      color:orders_list[index].deliveryStatusField==0?Color(0xFF004c4c):Colors.grey
                                  ),
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
  showSearchByPickingIdDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {
        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);
          Network_Operations.getDeliveryByPickingId(context,pickingId.text).then((delivery){
            if(delivery!=null) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => trackDeliveries(delivery)));
            }else{
              Utils.showError(context,"No Data Found against this picking Id");
            }
          });
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Search by Picking Id"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              attribute: 'Picking Id',
              controller: pickingId,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Picking Id",
              ),
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showSearchBySalesOrderDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {
        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);

        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Search by Sales Order"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              attribute: 'Sales Order No.',
              controller: salesOrderId,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Sales Order No.",
              ),
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
