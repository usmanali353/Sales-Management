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
  static Future<String> GetCustomerOnHand(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetCustomerOnHand/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerOnHandNoStock(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetCustomerOnHandNoStock/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetOnHandByItem(String itemNumber) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetOnHandByItem/'+itemNumber);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerInvoices(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetInvoices/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetInvoice(String InvoiceId) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetInvoice/'+InvoiceId);
    debugPrint(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProductInfo(String itemNumber) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetProductInfo/'+itemNumber);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProductsByModel(String CustomerId,String model,String sort,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetProductsByModel/'+CustomerId+'/'+model+'/'+sort+'/'+PageNo.toString()+'/'+PageSize.toString());
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProductsBySize(String CustomerId,String size,String sort,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetProductsBySize/'+CustomerId+'/'+size+'/'+sort+'/'+PageNo.toString()+'/'+PageSize.toString());
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
}