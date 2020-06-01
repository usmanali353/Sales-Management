import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Schedule/ScheduleDetails.dart';
import '../Utils.dart';

class SchedulesList extends StatefulWidget{
  var customerId;

  SchedulesList(this.customerId);

  @override
  State<StatefulWidget> createState() {
    return _SchedulesList(customerId);
  }

}
class _SchedulesList extends State<SchedulesList>{
  var schedules,temp=['',''],customerId,isVisible=false;
  _SchedulesList(this.customerId);
  @override
  void initState() {
    Utils.check_connectivity().then((connected){
      if(connected){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        Network_Operations.GetProductionSchedules(customerId, 1, 10).then((response){
          pd.hide();
          if(response!=null&&response!='[]'){
            setState(() {
              schedules=jsonDecode(response);
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
        title: Text("Schedules"),
      ),
      body: Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: ListView.builder(
                itemCount: schedules!=null?schedules.length:temp.length,
                itemBuilder: (context,int index){
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(schedules[index]['ItemDescription']!=null?schedules[index]['ItemDescription']:''),
                        subtitle: Text(schedules[index]['PlannedProdDate']!=null?'Planned Production Date:'+DateTime.fromMillisecondsSinceEpoch(int.parse(schedules[index]['PlannedProdDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                        leading:  Material(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.teal.shade100,
                            child: Padding(
                              padding: const EdgeInsets.only(top:10,bottom: 15,right: 10,left: 10),
                              child: Icon(FontAwesomeIcons.calendar,size: 30,color: Color(0xFF004c4c),),
                            )
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleDetails(schedules[index])));
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