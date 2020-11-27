import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

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
}