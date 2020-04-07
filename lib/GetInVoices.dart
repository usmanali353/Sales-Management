import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salesmanagement/InVoicesList.dart';

class GetInVoices extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetInVoices();
  }

}
class _GetInVoices extends State<GetInVoices>{
  TextEditingController CustomerId;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  @override
  void initState() {
    CustomerId=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Invoices"),),
      body: Column(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FormBuilderTextField(
                    controller: CustomerId,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              InvoicesList(CustomerId.text)));
                    }
                  },
                  child: Text("Get Invoice",style:TextStyle(color: Colors.white),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}