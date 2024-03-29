import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:acmc_customer/Model/DeliveryItems.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Utils.dart';
class TrackPalletPage extends StatefulWidget {
  @override
  _TrackPalletPageState createState() => _TrackPalletPageState();
}

class _TrackPalletPageState extends State<TrackPalletPage> {
  TextEditingController serialNo;
  DeliveryItems palletInfo;
  bool isVisible=false;
  GlobalKey<FormBuilderState> _fBKey=GlobalKey();
  @override
  void initState() {
    serialNo=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Pallet"),
      ),
      body: ListView(
        children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: FormBuilder(
               key: _fBKey,
               child: FormBuilderTextField(
                 attribute: "Serial No.",
                 controller: serialNo,
                 validators: [FormBuilderValidators.required()],
                 decoration: InputDecoration(
                   hintText: "Enter Pallet Serial No.",
                   prefixIcon: Icon(Icons.search),
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Color(0xFF004c4c), width: 1),
                   ),
                   focusedBorder:  OutlineInputBorder(
                     borderSide: BorderSide(color: Color(0xFF004c4c), width: 1),
                   ),
                   errorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Color(0xFF004c4c), width: 1),
                   ),
                   disabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Color(0xFF004c4c), width: 1),
                   ),
                   focusedErrorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Color(0xFF004c4c), width: 1),
                   ),
                 ),
               ),
             ),
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(color: Color(0xFF004c4c),onPressed: (){
                  if(_fBKey.currentState.validate()){
                    Network_Operations.getPalletInfo(context,serialNo.text).then((value){
                      setState(() {
                        if(value!=null){
                          this.isVisible=true;
                          this.palletInfo=value;
                        }else{
                          isVisible=false;
                        }
                      });
                    });
                  }

                }, icon:Icon(Icons.search,color: Colors.white,), label:Text("Search",style: TextStyle(color: Colors.white),)),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: RaisedButton.icon(color: Color(0xFF004c4c),onPressed: ()async{
                    String result = await FlutterBarcodeScanner.scanBarcode(
                        "#ff6666",
                        "Cancel",
                        true,
                        ScanMode.DEFAULT);
                    this.serialNo.text=result;

                  }, icon:Icon(FontAwesomeIcons.barcode,color: Colors.white,), label:Text("Scan",style: TextStyle(color: Colors.white),)),
                ),
              ],
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Visibility(
              visible: isVisible,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Item Number"),
                      trailing: Text(palletInfo!=null&&palletInfo.itemIdField!=null?palletInfo.itemIdField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Name"),
                      subtitle: Text(palletInfo!=null&&palletInfo.nameField!=null?palletInfo.nameField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Grade"),
                      trailing: Text(palletInfo!=null&&palletInfo.gradeField!=null?palletInfo.gradeField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Item Size"),
                      trailing: Text(palletInfo!=null&&palletInfo.sizeField!=null?palletInfo.sizeField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Shade"),
                      trailing: Text(palletInfo!=null&&palletInfo.shadeField!=null?palletInfo.shadeField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Warehouse Location"),
                      subtitle: Text(palletInfo!=null&&palletInfo.warehouseLocationField!=null?palletInfo.warehouseLocationField:''),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Quantity in Pallet"),
                      trailing: Text(palletInfo!=null&&palletInfo.salesQtyField!=null?palletInfo.salesQtyField.toString():''),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
