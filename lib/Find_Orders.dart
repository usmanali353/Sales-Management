import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salesmanagement/SearchedOrderDetail.dart';

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
  @override
  void initState() {
       order_number_controller=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
            return Scaffold(
              appBar: AppBar(title: Text("Find Orders"),),
              body: Container(
                height: 1000,
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Color(0xFFa2ffff)])     ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextField(
                              controller:order_number_controller,

                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: MaterialButton(
                              color: Colors.teal,
                              onPressed: (){
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
                              },

                              child: Text("Search",style:TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
  }

}