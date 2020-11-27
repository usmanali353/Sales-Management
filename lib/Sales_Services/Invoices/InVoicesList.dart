import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:salesmanagement/Model/Invoices.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../Utils.dart';
import 'InvoiceDetail.dart';
import 'package:salesmanagement/Network_Operations.dart';

class InvoicesList extends StatefulWidget{
  var CustomerId;

  InvoicesList(this.CustomerId);

  @override
  State<StatefulWidget> createState() {
    return _InvoicesList(CustomerId);
  }

}
class _InvoicesList extends State<InvoicesList>{
  var CustomerId,isVisible=false,temp=['',''],paidChecked=true,unpaidChecked=false;
  List<Invoices> InvoiceList=[];
  DateTime selectedDate=DateTime.now();
  TextEditingController invoiceNumber;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();
  _InvoicesList(this.CustomerId);
  @override
  void initState() {
    invoiceNumber=TextEditingController();
    Utils.check_connectivity().then((connected){
      if(connected){
        Network_Operations.GetCustomerInvoices(context,CustomerId, 1, 10).then((invoices){
          if(invoices!=null){
            setState(() {
              this.InvoiceList=invoices;
              this.isVisible=true;
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
        title: Text("Finance"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              if(choice=='Search By Invoice Number'){
                showInvoiceNumberAlertDialog(context);
              }else if(choice=='Search By Date') {
                showDateAlertDialog(context);
              }
            },
            itemBuilder: (BuildContext context){
              return ['Search By Invoice Number','Search By Date'].map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },

          )
        ],
      ),

      body:Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Wrap(
              children: <Widget>[
               FilterChip(
                 label: Text("Paid"),
                 selected: paidChecked,
                 onSelected: (selected){
                    setState(() {
                      paidChecked=true;
                      unpaidChecked=false;
                    });
                    Network_Operations.GetCustomerInvoices(context,CustomerId, 1, 100).then((invoices){
                      if(invoices!=null){
                        setState(() {
                          if(InvoiceList!=null){
                            InvoiceList.clear();
                          }
                          this.InvoiceList=invoices;

                          this.isVisible=true;
                        });
                      }
                    });
                 },
               ),
               SizedBox(width: 6,) ,
                FilterChip(
                  label: Text("Un Paid"),
                  selected: unpaidChecked,
                  onSelected: (selected){
                    setState(() {
                      paidChecked=false;
                      unpaidChecked=true;
                    });
                    Network_Operations.GetCustomerInvoices(context,CustomerId, 1, 100).then((invoices){
                      if(invoices!=null){
                        setState(() {
                          if(InvoiceList!=null){
                            InvoiceList.clear();
                          }
                          this.InvoiceList=invoices;
                          this.isVisible=true;
                        });
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:16,right:16,bottom: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: ListView.builder(
                      itemCount: InvoiceList!=null?InvoiceList.length:temp.length,
                      itemBuilder: (context,int index){
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(InvoiceList[index].deliveryName!=null?InvoiceList[index].deliveryName.trim():''),
                              trailing: Text(InvoiceList[index].invoiceDate!=null?DateTime.fromMillisecondsSinceEpoch(int.parse(InvoiceList[index].invoiceDate.replaceAll('/Date(','').replaceAll(')/','').replaceAll('+0300',''))).toString().split(' ')[0]:''),
                              subtitle: Text('Sales Id:'+InvoiceList[index].salesOrderId+'\n'+'Quantity Sold: '+InvoiceList[index].quantitySold.toString()+"\n"+"Total: "+InvoiceList[index].salesAmount.toString()),
                              leading: Material(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.teal.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,bottom: 16,right: 10,left: 10),
                                    child: Icon(FontAwesomeIcons.fileInvoice,size: 30,color: Color(0xFF004c4c),),
                                  )
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoiceDetails(InvoiceList[index])));
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
        ],
      ),
    );
  }
  showInvoiceNumberAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {
        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);
          Network_Operations.GetInvoice(context,invoiceNumber.text).then((response) {
            if (response != null) {
              var detail = jsonDecode(response);
              if (detail['DueDate'] != "/Date(-2208956400000+0300)/") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => InvoiceDetails(detail)));
              }else{
                Flushbar(
                  message:  "No Invoice Found against this number",
                  backgroundColor: Colors.red,
                  duration:  Duration(seconds: 5),
                )..show(context);
              }
            }
          });
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Enter Invoice Number"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              attribute: 'Invoice Number',
              controller: invoiceNumber,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Invoice Number",
              ),
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
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
  showDateAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget search = FlatButton(
      child: Text("Search"),
      onPressed:  () {

        if(_fbKey.currentState.validate()) {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Search by Date"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: FormBuilderDateTimePicker(
              attribute: 'Invoice Date',
              format: DateFormat("yyyy-MM-dd"),
              inputType: InputType.date,
              validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                hintText: "Invoice Date",
              ),
              onChanged: (value){
                this.selectedDate=value;
              },
            ),
          )

        ],
      ),
      actions: [
        cancelButton,
        search
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