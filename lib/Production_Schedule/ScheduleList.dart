import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salesmanagement/Production_Schedule/ScheduleDetails.dart';

class SchedulesList extends StatefulWidget{
  var schedules;

  SchedulesList(this.schedules);

  @override
  State<StatefulWidget> createState() {
    return _SchedulesList(schedules);
  }

}
class _SchedulesList extends State<SchedulesList>{
  var schedules,temp=['',''];
  _SchedulesList(this.schedules);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedules"),
      ),
      body: ListView.builder(
          itemCount: schedules!=null?schedules.length:temp.length,
          itemBuilder: (context,int index){
            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(schedules[index]['ItemDescription']!=null?schedules[index]['ItemDescription']:''),
                  subtitle: Text(schedules[index]['ActualProdDate']!=null?schedules[index]['ActualProdDate']:''),
                  leading: Icon(FontAwesomeIcons.calendar),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleDetails(schedules[index])));
                  },
                ),
                Divider(),
              ],
            );
          }),
    );

  }

}