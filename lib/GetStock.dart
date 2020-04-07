import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salesmanagement/StockItemsList.dart';

class GetStock extends StatefulWidget{
  var zero;

  GetStock(this.zero);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetStock(zero);
  }

}
class _GetStock extends State<GetStock>{
  var customerId,zero;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _GetStock(this.zero);

  @override
  void initState() {
   customerId=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Find Stock"),),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
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
                MaterialButton(
                  color: Colors.teal,
                  onPressed: (){
                    if(_fbKey.currentState.validate()) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              StockItemsList(zero, customerId.text)));
                    }
                  },

                  child: Text("Find Stock",style:TextStyle(color: Colors.white),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}