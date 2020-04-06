import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salesmanagement/ItemStockDetail.dart';
class GetItemStock extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetItemStock();
  }
}
class _GetItemStock extends State<GetItemStock>{
  TextEditingController itemNumber;
  @override
  void initState() {
    setState(() {
      this.itemNumber=TextEditingController();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Item Stock"),),
      body: Column(
        children: <Widget>[
          FormBuilder(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
                    controller: itemNumber,
                    attribute: "Item Number",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(labelText: "Item Number",
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemStockDetail(itemNumber.text)));
                  },
                  child: Text("Get Stock",style:TextStyle(color: Colors.white),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}