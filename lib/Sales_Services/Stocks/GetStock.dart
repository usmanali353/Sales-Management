import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Network_Operations.dart';
import 'GetItemStock.dart';
import 'StockItemsList.dart';

class GetStock extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetStock();
  }

}
class _GetStock extends State<GetStock>{
  var customerId,selectedValue;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _GetStock();

  @override
  void initState() {
   customerId=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Stock"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Stock of Specific Item'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GetItemStock()));
              }
            },
            itemBuilder: (BuildContext context){
              return ['Stock of Specific Item'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderDropdown(
                    attribute: "Find by",
                    validators: [FormBuilderValidators.required()],
                    hint: Text("Find by"),
                    items: ['Available Stock','Finished Stock','Older Stock'].map((trainer)=>DropdownMenuItem(
                      child: Text(trainer),
                      value: trainer,
                    )).toList(),
                    style: Theme.of(context).textTheme.body1,
                    decoration: InputDecoration(labelText: "Find by",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                    onChanged: (value){
                      setState(() {
                        this.selectedValue=value;
                        customerId.text="";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16,left: 16),
                  child: FormBuilderTextField(
                    controller: customerId,
                    attribute: "Customer Id",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Customer Id",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (BuildContext context){
                    return Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: MaterialButton(
                        color: Colors.teal,
                        onPressed: (){
                          if(_fbKey.currentState.validate()) {
                            if(selectedValue=='Available Stock'){
                              Network_Operations.GetCustomerOnHand(context,customerId.text, 1, 10).then((response){
                                if(response!=null&&response!=''&&response!='[]'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StockItemsList(selectedValue, jsonDecode(response))));
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Stock Not Found"),
                                  ));
                                }
                              });
                            }else if(selectedValue=='Finished Stock'){
                              Network_Operations.GetCustomerOnHandNoStock(context,customerId.text, 1, 10).then((response){
                                if(response!=null&&response!=''&&response!='[]'){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StockItemsList(selectedValue, jsonDecode(response))));
                                }
                              });
                            }else{
//                              Network_Operations.GetCustomerOlderStock(customerId.text, 1, 10).then((response){
//                                pd.hide();
//                                if(response!=null&&response!=''&&response!='[]'){
//                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StockItemsList(selectedValue, jsonDecode(response))));
//                                }else{
//                                  Scaffold.of(context).showSnackBar(SnackBar(
//                                    backgroundColor: Colors.red,
//                                    content: Text("Stock Not Found"),
//                                  ));
//                                }
//                              });
                            }

                          }
                        },

                        child: Text("Find Stock",style:TextStyle(color: Colors.white),),
                      ),
                    );
                  },

                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}