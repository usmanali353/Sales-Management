import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acmc_customer/Model/Deliveries.dart';
import 'package:acmc_customer/Model/DeliveryItems.dart';
class LoadedPallets extends StatefulWidget {
  DeliveryItems deliveryItems;
  LoadedPallets(this.deliveryItems);
  @override
  _LoadedPalletsState createState() => _LoadedPalletsState();
}

class _LoadedPalletsState extends State<LoadedPallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loaded Pallets"),
      ),
      body: ListView.builder(
          itemCount: widget.deliveryItems.palletsField!=null?widget.deliveryItems.palletsField.length:0,
          itemBuilder:(context,index){
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 12),
                    child: Row(
                      children: [
                        FaIcon(FontAwesomeIcons.barcode,color: Color(0xFF004c4c),),
                        SizedBox(
                          width: 8,
                        ),
                        Text(widget.deliveryItems.palletsField[index].serialField!=null?widget.deliveryItems.palletsField[index].serialField:'',style: TextStyle(color:Color(0xFF004c4c),fontSize: 18,fontWeight: FontWeight.bold)),

                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Grade"),
                          subtitle: Text(widget.deliveryItems.palletsField[index].gradeField!=null?widget.deliveryItems.palletsField[index].gradeField:''),
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
                                  FontAwesomeIcons.galacticRepublic,
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
                          title: Text("Quantity"),
                          subtitle: Text(widget.deliveryItems.palletsField[index].salesQtyField!=null?widget.deliveryItems.palletsField[index].salesQtyField.toString():"0"),
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
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text("Shade"),
                          subtitle: Text(widget.deliveryItems.palletsField[index].shadeField!=null?widget.deliveryItems.palletsField[index].shadeField:""),
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
                                  FontAwesomeIcons.palette,
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
                          title: Text("Size"),
                          subtitle: Text(widget.deliveryItems.palletsField[index].sizeField!=null?widget.deliveryItems.palletsField[index].sizeField:""),
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
                                  FontAwesomeIcons.ruler,
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
                ],
              ),
            ),
        );
      }),
    );
  }
}
