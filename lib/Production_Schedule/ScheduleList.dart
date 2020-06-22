import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Production_Schedule/ScheduleDetails.dart';
import '../Utils.dart';

class SchedulesList extends StatefulWidget{
  var customerId,scheduleByRequest;

  SchedulesList(this.customerId,this.scheduleByRequest);

  @override
  State<StatefulWidget> createState() {
    return _SchedulesList(customerId,scheduleByRequest);
  }

}
class _SchedulesList extends State<SchedulesList>{
  var schedules,temp=['',''],customerId,isVisible=false,selectedValue,scheduleByRequest;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  _SchedulesList(this.customerId,this.scheduleByRequest);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedules"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Network_Operations.GetOnhandStock(customerId).then((value){
                if(value!=null){
                  setState(() {
                    var items = jsonDecode(value);
                    List<String> itemNames = [];
                    if (items != null && items.length > 0) {
                      itemNames.insert(0, 'All');
                      for (int i = 1; i < items.length; i++) {
                        itemNames.add(items[i]['ItemDescription']);
                      }
                      showAlertDialog(context, itemNames, items);
                    }
                  });
                }
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
             if(connected){
               ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
               pd.show();
               Network_Operations.GetProductionSchedules(customerId, 1, 100).then((response){
                 pd.dismiss();
                 if(response!=null&&response!='[]'){
                   if(schedules!=null){
                     schedules.clear();
                   }
                   schedules=jsonDecode(response);
                   setState(() {
                     isVisible=true;
                   });
                 }
               });
             }else{
                 Flushbar(
                   message: "Network Not Available",
                   backgroundColor: Colors.red,
                   duration: Duration(seconds: 5),
                 )..show(context);
             }
          });
        },
        child: Visibility(
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
      ),
    );

  }
  showAlertDialog(BuildContext context,List<String> itemsNames,var items) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Ok"),
      onPressed:  () {
        Network_Operations.GetProductionSchedulesByItem(customerId,items[selectedValue]['ItemNumber'], 1, 100).then((value){
          if(value!=null){
            setState(() {
              var requestsByItem=jsonDecode(value);
              if (selectedValue == 0) {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) =>
                    _refreshIndicatorKey.currentState
                        .show());
              }else if(requestsByItem!=null&&requestsByItem.length>0) {
                schedules.clear();
                schedules.addAll(requestsByItem);
                Navigator.pop(context);
              }else{
                Flushbar(
                  message:  "No Requests Found",
                  backgroundColor: Colors.red,
                  duration:  Duration(seconds: 5),
                )..show(context);
                Navigator.pop(context);
              }
            });
          }
        });

      },
    );
    Widget launchButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Filter by Item"),
      content:FormBuilder(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FormBuilderDropdown(
                attribute: "Select Item",
                hint: Text("Select Item"),
                items: itemsNames!=null?itemsNames.map((plans)=>DropdownMenuItem(
                  child: Text(plans),
                  value: plans,
                )).toList():[""].map((name) => DropdownMenuItem(
                    value: name, child: Text("$name")))
                    .toList(),
                onChanged: (value){
                  setState(() {
                    this.selectedValue=itemsNames.indexOf(value);
                  });
                },
                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(fontSize: 11)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(16),
                ),

              ),
            ],
          )
      ),
      actions: [
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}