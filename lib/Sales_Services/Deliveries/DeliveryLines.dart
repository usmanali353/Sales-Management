import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Model/Deliveries.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/LoadedPallets.dart';
class DeliveryLines extends StatefulWidget {
  Deliveries delivery;

  DeliveryLines(this.delivery);

  @override
  _DeliveryLinesState createState() => _DeliveryLinesState();
}

class _DeliveryLinesState extends State<DeliveryLines> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Included Items"),),
      body:ListView.builder(
        itemCount: widget.delivery.deliveryItemsField!=null?widget.delivery.deliveryItemsField.length:0,
          itemBuilder:(context,index){
        return InkWell(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder:(context)=>LoadedPallets(widget.delivery.deliveryItemsField[index])));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0,top: 8.0,left: 16),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.box,color: Color(0xFF004c4c),),
                        SizedBox(
                          width: 8,
                        ),
                        Text(widget.delivery.deliveryItemsField[index].itemIdField!=null?widget.delivery.deliveryItemsField[index].itemIdField:'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF004c4c)),)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Quantity"),
                          subtitle: Text(widget.delivery.deliveryItemsField[index].salesQtyField!=null?widget.delivery.deliveryItemsField[index].salesQtyField.toString():"0"),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF004c4c)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.pallet,
                                  size: 20,
                                  color: Color(0xFF004c4c),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text("Loaded Quantity"),
                          subtitle: Text(widget.delivery.deliveryItemsField[index].reservedQtyField!=null?widget.delivery.deliveryItemsField[index].reservedQtyField.toString():"0"),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: Color(0xFF004c4c)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.truckLoading,
                                  size: 20,
                                  color: Color(0xFF004c4c),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: FAProgressBar(
                        direction: Axis.horizontal,
                        currentValue: widget.delivery.deliveryItemsField[index].reservedPercentField!=null?widget.delivery.deliveryItemsField[index].reservedPercentField:0,
                        size: 20,
                        border: Border.all(width: 1,color: Colors.grey),
                        progressColor: Color(0xFF004c4c),
                        displayText: "%",
                        animatedDuration: Duration(seconds: 5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
