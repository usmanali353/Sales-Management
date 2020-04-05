import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Network_Operations {
  static Future<String> find_orders(String order_number) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/FindSalesOrder/'+order_number);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> get_deliveries(String date,String CustomerId) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetDeliveries/'+CustomerId+'/'+date);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetSalesOrders(String start_date,String end_date,String CustomerId) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetSalesOrders/'+CustomerId+'/'+start_date+'/'+end_date);
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerOnHand(String CustomerId,String PageNo,String PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetCustomerOnHand/'+CustomerId+'/'+PageNo+'/'+PageSize);
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerOnHandNoStock(String CustomerId,String PageNo,String PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetCustomerOnHandNoStock/'+CustomerId+'/'+PageNo+'/'+PageSize);
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
}