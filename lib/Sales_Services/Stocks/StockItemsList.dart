import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
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
          Network_Operations.GetCustomerOnHand(customerId, 1, 10).then((response){
            pd.hide();
            if(response!=null&&response!='[]'){
             setState(() {
               items=jsonDecode(response);
               isVisible=true;
             });
            }
          });
        }else if(title=='Finished Stock'){
          Network_Operations.GetCustomerOnHandNoStock(customerId, 1, 10).then((response){
            pd.hide();
            if(response!=null&&response!='[]'){
                   setState(() {
                     items=jsonDecode(response);
                     isVisible=true;
                   });

            }
          });
        }else{
          Network_Operations.GetCustomerOlderStock(customerId, 1, 10).then((response){
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
        child: ListView.builder(
            itemCount: items!=null?items.length:temp.length,
            itemBuilder: (context,int index){
           return Column(
             children: <Widget>[
               ListTile(
                 title: Text(items[index]['ItemDescription']!=null?items[index]['ItemDescription']:''),
                 leading: Icon(FontAwesomeIcons.boxOpen,size: 30,),
                 trailing: Text(items[index]['OnHandQty']!=null?items[index]['OnHandQty'].toString():items[index]['QtyAvailablePhysical'].toString()),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>StockItemDetail(items[index])));
                 },
               ),
               Divider(),
             ],
           );
        }),
      ),
    );
  }
}