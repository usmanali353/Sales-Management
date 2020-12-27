import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/TrackPalletPage.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/trackDeliveries.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/trackDeliveryList.dart';
import 'package:acmc_customer/main.dart';

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
     /*
     Live Server
     http://mobileapi.arabian-ceramics.com/ACMCMobileServicesLive/
     */
    return "http://mobileapi.arabian-ceramics.com/ACMCMobileServices/"; //"http://sales.arabianceramics.com/AcmcMobileServices/";
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
    String  barcode;
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "Cancel",
          true,
          ScanMode.DEFAULT);
      barcode=result;
      if(result!=null&&result!=""&&result.contains("PKL")) {
        Network_Operations.getDeliveryByPickingId(context, result).then((
            value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => trackDeliveries(value)));
        });
      }else{
        Utils.showError(context,"Invalid Picking Id");
      }
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
  static void setupQuickActions(BuildContext context) {
    QuickActions quickActions=QuickActions();
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'track_pallets',
          localizedTitle: 'Track Pallets',
          icon: "track_pallets"
      ),
      ShortcutItem(
          type: 'track_deliveries',
          localizedTitle: 'Track Deliveries',
          icon: "track_delivery"
      )
      // icon: Platform.isAndroid ? 'quick_heart' : 'QuickHeart')
    ]);
    quickActions.initialize((shortcutType) {
      if (shortcutType == 'track_pallets') {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>TrackPalletPage()), (route) => false);
      } else if(shortcutType == 'track_deliveries') {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => trackDeliveryList("2019-09-15","LC0001")),(route) => false);
      }
    });
  }
}