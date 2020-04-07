import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'SearchedOrderDetail.dart';

class FindOrders extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FindOrdersState();
  }

}
class _FindOrdersState extends State<FindOrders>{
  TextEditingController order_number_controller;
  var OrderData;
  bool TableVisible=false;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
       order_number_controller=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(title: Text("Find Orders"),),
              body: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: FormBuilderTextField(
                            controller: order_number_controller,
                            attribute: "Order Number",
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: "Order Number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9.0),
                                  borderSide: BorderSide(color: Colors.teal, width: 1.0)
                              ),
                            ),

                          ),
                        ),
                        MaterialButton(
                          color: Colors.teal,
                          onPressed: (){
                            if(_fbKey.currentState.validate()){
                              if(order_number_controller.text!=null) {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        SearchedOrderDetail(
                                            order_number_controller.text)));
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Enter Order Number"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }

                          },

                          child: Text("Search",style:TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            );
  }

}