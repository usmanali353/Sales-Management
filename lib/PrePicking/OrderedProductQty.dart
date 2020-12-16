import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:acmc_customer/Model/Products.dart';
import 'package:acmc_customer/Model/sqlite_helper.dart';
class OrderedProductQty extends StatefulWidget {
  var variationData;

  OrderedProductQty(this.variationData);

  @override
  _OrderedProductQtyState createState() => _OrderedProductQtyState(variationData);
}

class _OrderedProductQtyState extends State<OrderedProductQty> {
  var variationData;
  sqlite_helper db;
  TextEditingController quantity;
   GlobalKey<FormBuilderState> _fbKey=GlobalKey();
  _OrderedProductQtyState(this.variationData);
 @override
  void initState() {
    quantity=TextEditingController();
    db=sqlite_helper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Quantity"),),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Center(
                child: Text(variationData['Onhand']-variationData['OnOrdered']>1?'Available Quantity: '+(variationData['Onhand']-variationData['OnOrdered']).toStringAsFixed(2).toString():'0.0',style: TextStyle(fontSize: 20))
            ),
          ),
          FormBuilder(
            key: _fbKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child:  Card(
                      elevation: 10,
                      child: FormBuilderTextField(
                        controller: quantity,
                        attribute: "Quantity",
                        keyboardType: TextInputType.number,
                        validators: [FormBuilderValidators.required()],
                        decoration: InputDecoration(hintText: "Quantity",contentPadding: EdgeInsets.all(16),border: InputBorder.none
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(9.0),
//                            borderSide: BorderSide(color: Colors.teal, width: 1.0)
//                        ),
                        ),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (BuildContext context){
                      return MaterialButton(
                        color:Color(0xFF004c4c),
                        onPressed: (){
                          setState(() {
                            var as=variationData['Onhand']-variationData['OnOrdered']>1?variationData['Onhand']-variationData['OnOrdered']:0.0;
                            print(variationData['OnOrdered'].toString());
                            if(quantity.text==null||quantity.text==""){
                              Flushbar(
                                message:  "Enter Quantity",
                                backgroundColor: Colors.red,
                                duration:  Duration(seconds: 5),
                              )..show(context);
                            } else if(variationData['Onhand']-variationData['OnOrdered']<2.0){
                              Flushbar(
                                message:  "OnHand Stock too low to order",
                                backgroundColor: Colors.red,
                                duration:  Duration(seconds: 5),
                              )..show(context);
                            }else if(double.parse(quantity.text)>=as){
                              Flushbar(
                                message:  "Quantity should be less the the OnHand Stock",
                                duration:  Duration(seconds: 5),
                                backgroundColor: Colors.red,
                              )..show(context);
                            }else{
                              db.checkAlreadyExists(variationData['InventoryDimension']).then((alreadyExist){
                                if(alreadyExist.length>0){
                                  Flushbar(
                                    message:  "Product already Exists",
                                    backgroundColor: Colors.red,
                                    duration:  Duration(seconds: 5),
                                  )..show(context);
                                }else {
                                  Products products=Products(variationData['ItemDescription'],variationData['ItemNumber'],variationData['ItemSize'],variationData['InventoryDimension'],variationData['ItemColor'],'',variationData['ItemGrade'],double.parse(quantity.text));
                                  db.addProducts(products);
//                                  Flushbar(
//                                    message:  "Product added for Order",
//                                    backgroundColor: Colors.green,
//                                    duration:  Duration(seconds: 5),
//                                  )..show(context);
                                    Navigator.pop(context,'Close');
                                }
                              });
                              // Navigator.pop(context);
                            }
                          });
                        },
                        child: Text("Add",style: TextStyle(color: Colors.white),),
                      );
                    },
                  )
                ],
              )
          )

        ],
      ),
    );
  }
}
