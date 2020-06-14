import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/PrePicking/ProductVariations.dart';
import '../../Utils.dart';
import 'StockItemsDetails.dart';

class StockItemsList extends StatefulWidget{
  var customerId,title;

  StockItemsList(this.title,this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _StockItemsList(this.title,this.customerId);
  }

}
class _StockItemsList extends State<StockItemsList>{
  var customerId,title,temp=['',''],items,isVisible=false;

  _StockItemsList(this.title,this.customerId);
@override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,isDismissible: true,type: ProgressDialogType.Normal);
        pd.show();
        if(title=='Available Stock'){
          Network_Operations.GetOnhandStock(customerId).then((response){
            pd.hide();
            if(response!=null&&response!='[]'){
             setState(() {
               items=jsonDecode(response);
               isVisible=true;
             });
            }
          });
        }else if(title=='Finished Stock'){
          Network_Operations.GetCustomerOnHandNoStock(customerId, 1, 100).then((response){
            pd.hide();
            if(response!=null&&response!='[]'){
                   setState(() {
                     items=jsonDecode(response);
                     isVisible=true;
                   });

            }
          });
        }else{
          Network_Operations.GetCustomerOlderStock(customerId).then((response){
            pd.hide();
            if(response!=null&&response!='[]'){
                setState(() {
                  items=jsonDecode(response);
                  isVisible=true;
                });

            }
          });
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListView.builder(
                itemCount: items!=null?items.length:temp.length,
                itemBuilder: (context,int index){
               return Column(
                 children: <Widget>[
                   ListTile(
                     title: Text(items[index]['ItemDescription']!=null?items[index]['ItemDescription']:''),
                     leading:  Material(
                         borderRadius: BorderRadius.circular(24),
                         color: Colors.teal.shade100,
                         child: Padding(
                           padding: const EdgeInsets.only(top:10,bottom: 15,right: 15,left: 10),
                           child: Icon(FontAwesomeIcons.boxOpen,size: 30,color: Color(0xFF004c4c),),
                         )
                     ),
                     subtitle: Text((() {
                      if(items[index]['OnhandALL']!=null){
                        return 'Quantity: '+items[index]['OnhandALL'].toString();
                      }else if(items[index]['QtyAvailablePhysical']!=null){
                        return 'Quantity: '+items[index]['QtyAvailablePhysical'].toString();
                      }else
                        return 'Quantity: '+items[index]['OnHandQty'].toString();
                     })()), //Text(items[index]['OnhandALL']!=null?items[index]['OnhandALL'].toString():items[index]['QtyAvailablePhysical'].toString()),
                     onTap: (){
                       if(title!='Finished Stock'){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductVariations(items[index]['ItemNumber'],null,null,null,null,null,true)));
                         }else{
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemDetail(items[index])));
                       }
                     },
                   ),
                   Divider(),
                 ],
               );
            }),
          ),
        ),
      ),
    );
  }
}