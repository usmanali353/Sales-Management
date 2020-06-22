import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:need_resume/need_resume.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Model/sqlite_helper.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/VariationsDetails.dart';
import '../Utils.dart';
class ProductVariations extends StatefulWidget {
  var itemNumber,customerId;

  ProductVariations(this.itemNumber,this.customerId);

  @override
  _ProductVariationsState createState() => _ProductVariationsState(itemNumber,customerId);
}

class _ProductVariationsState extends ResumableState<ProductVariations> {
  var itemNumber,total,totalProductionRequests=0,deliveryDate, driverName, truckNumber,address,mobileNo,forDetail,customerId;

  var isVisible=false;
  var variations;
  TextEditingController quantity;
  _ProductVariationsState(this.itemNumber,this.customerId);

  @override
  void onResume() {
    if(resume.data.toString()=='Close'){
      Navigator.pop(context,'Refresh');
    }
  }

  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        Network_Operations.GetOnhandStockByItem(customerId,itemNumber).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              variations=jsonDecode(response);
              isVisible=true;
            });
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text('Available Variations'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context,'Refresh');
          return false;
        },
        child: Visibility(
          visible: isVisible,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: ListView.builder(itemCount:variations!=null?variations.length:0,itemBuilder: (BuildContext context,int index){
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(variations[index]['ItemSize']),
                      subtitle: Text('Color: '+variations[index]['ItemColor']),
                      trailing: Text(variations[index]['Onhand']-variations[index]['OnOrdered']>1?'Qty:'+(variations[index]['Onhand']-variations[index]['OnOrdered']).toString():'0'),
                      leading:  Material(
                borderRadius: BorderRadius.circular(24),
                color: Colors.teal.shade100,
                child: Padding(
                padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                child: Icon(FontAwesomeIcons
                    .boxes,size: 30,color: Color(0xFF004c4c),),
                )
                ),
                      onTap: (){
                      push(context, MaterialPageRoute(builder: (context)=>VariationDetails(variations[index],customerId)));
                      },
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

}
