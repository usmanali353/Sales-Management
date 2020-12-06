import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/PalletDetails.dart';
import 'package:salesmanagement/Sales_Services/Deliveries/trackDeliveries.dart';

class Utils{
  static Future<bool> check_connectivity () async{
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }
  static dynamic myEncode(dynamic item) {
    if(item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
  static String getBaseUrl(){
    return "http://sales.arabianceramics.com/AcmcMobileServices/";
  }
  static String apiAuthentication(){
     String username = 'AcmcUser';
     String password = 'Aujc?468';
     String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
     return basicAuth;
  }
  static showSuccess(BuildContext context,String message){
    Flushbar(
      backgroundColor: Colors.green,
      duration: Duration(seconds: 5),
      message: message,
    )..show(context);
  }
  static showError(BuildContext context,String message){
    Flushbar(
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
      message: message,
    )..show(context);
  }
  static String getDeliveryStatus(int id){
    if(id==0){
      return "Open";
    }else if(id==1){
      return "Closed";
    }else if(id==2){
      return "Cancelled";
    }
    return null;
  }
  static String getCaseType(int CategoryTypeId){
    String type;
    if(CategoryTypeId==5637145326){
      type="Inquiry";
    }
    if(CategoryTypeId==5637144576){
      type="Complaint";
    }
    return type;
  }
  static Future scan(BuildContext context) async {
    ScanResult  barcode;
    try {
      barcode = (await BarcodeScanner.scan());
      barcode = barcode;
      if(barcode.rawContent!=null){
        Network_Operations.getDeliveryByPickingId(context,barcode.rawContent).then((delivery){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>trackDeliveries(delivery)));
        });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        Flushbar(
          message: "Camera Access not Granted",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ).show(context);
      } else {
        Flushbar(
          message: e.toString(),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    } on FormatException{
      Flushbar(
        message: "User returned using the back-button before scanning anything",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
    } catch (e) {
      Flushbar(
        message: e,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
    }
    return barcode;
  }
  static String getResolutionType(int resolutionType){
    String  restype;
    if(resolutionType==0){
      restype='None';
    }else if(resolutionType==1){
      restype='Accept';
    }else if(resolutionType==2){
      restype='Reject';
    }
    return restype;
  }
  static Future scanPalletSerialNo(BuildContext context) async {
    ScanResult  barcode;
    try {
      barcode = (await BarcodeScanner.scan());
      barcode = barcode;
      if(barcode.rawContent!=null){
        Network_Operations.getPalletInfo(context,barcode.rawContent).then((delivery){
          Navigator.push(context,MaterialPageRoute(builder:(context)=>PalletDetails(delivery)));
        });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        Flushbar(
          message: "Camera Access not Granted",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ).show(context);
      } else {
        Flushbar(
          message: e.toString(),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ).show(context);
      }
    } on FormatException{
      Flushbar(
        message: "User returned using the back-button before scanning anything",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
    } catch (e) {
      Flushbar(
        message: e,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ).show(context);
    }
    return barcode;
  }
}