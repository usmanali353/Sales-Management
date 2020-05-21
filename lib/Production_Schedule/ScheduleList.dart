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
        child: ListView.builder(
            itemCount: schedules!=null?schedules.length:temp.length,
            itemBuilder: (context,int index){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(schedules[index]['ItemDescription']!=null?schedules[index]['ItemDescription']:''),
                    subtitle: Text(schedules[index]['PlannedProdDate']!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(schedules[index]['PlannedProdDate'].replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                    leading: Icon(FontAwesomeIcons.calendar),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleDetails(schedules[index])));
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