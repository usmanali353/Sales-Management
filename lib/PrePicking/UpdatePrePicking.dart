import'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/AddProducts.dart';
class UpdatePrePicking extends StatefulWidget {
  var prePicking;

  UpdatePrePicking(this.prePicking);

  @override
  _UpdatePrePickingState createState() => _UpdatePrePickingState(prePicking);
}

class _UpdatePrePickingState extends State<UpdatePrePicking> {
  var prePicking;
   List<Map> prePickingLines=[];
  _UpdatePrePickingState(this.prePicking);

  final GlobalKey<FormBuilderState> _fbKey=GlobalKey();
  DateTime deliveryDate=DateTime.now();
  TextEditingController driverName,truckNumber,address,mobileNo;

  @override
  void initState() {
    driverName=TextEditingController();
    truckNumber=TextEditingController();
    address=TextEditingController();
    mobileNo=TextEditingController();
    driverName.text=prePicking['DriverName'];
    truckNumber.text=prePicking['TruckPlate'];
    address.text=prePicking['Address'];
    mobileNo.text=prePicking['MobileNum'];
    for(int i=0;i<prePicking['PrePickingLines'].length;i++){
      prePickingLines.add(
        {
          "ColorItem":prePicking['PrePickingLines'][i]['ColorItem'],
           "Grade":prePicking['PrePickingLines'][i]['Grade'],
           "InventoryDimension":prePicking['PrePickingLines'][i]['InventoryDimension'],
          "ItemNumber": prePicking['PrePickingLines'][i]['ItemNumber'],
          "PickingId": prePicking['PrePickingLines'][i]['PickingId'],
           "SalesQuantity": prePicking['PrePickingLines'][i]['SalesQuantity'],
          "SizeItem":prePicking['PrePickingLines'][i]['SizeItem']
        }
      );
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add PrePicking"),),
      body: ListView(
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                  child: FormBuilderTextField(
                    controller: address,
                    attribute: "Address",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: mobileNo,
                    attribute: "Mobile No",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Mobile No",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),
                  child:FormBuilderDateTimePicker(
                    attribute: "date",
                    initialValue: DateTime.parse(DateTime.fromMillisecondsSinceEpoch(int.parse(prePicking['DeliveryDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]),
                    style: Theme.of(context).textTheme.body1,
                    inputType: InputType.date,
                    validators: [FormBuilderValidators.required()],
                    format: DateFormat("MM-dd-yyyy"),
                    decoration: InputDecoration(labelText: "Delivery Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide: BorderSide(color: Colors.teal, width: 1.0)
                      ),),
                    onChanged: (value){
                      setState(() {
                        this.deliveryDate=value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16),
                  child: FormBuilderTextField(
                    controller: driverName,
                    attribute: "Driver Name",
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Driver Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:16,left: 16, right: 16),
                  child: FormBuilderTextField(
                    controller: truckNumber,
                    attribute: "Truck Number",
                    keyboardType: TextInputType.number,
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Truck Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 1.0)),
                    ),
                  ),
                ),
                Builder(
                  builder:(BuildContext context){
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: MaterialButton(
                          color: Colors.teal[800],
                          child: Text("Update PrePicking"),
                          onPressed: (){
                            if(_fbKey.currentState.validate()) {
                              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
                              pd.show();
                              Network_Operations.updatePrePicking(prePicking['CustomerAccount'], address.text, driverName.text, truckNumber.text, '/Date('+deliveryDate.millisecondsSinceEpoch.toString()+'+0300)/', mobileNo.text, prePickingLines, prePicking['PickingId']).then((response){
                                pd.dismiss();
                                if(response!=null){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Pre Picking Updatedd"),
                                    backgroundColor: Colors.green,
                                  ));
                                  Navigator.pop(context,'Refresh');
                                }else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Pre Picking not Updatedd"),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              });
                            }
                          },
                        ),
                      ),
                    );
                  }

                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
