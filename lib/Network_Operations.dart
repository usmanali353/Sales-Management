import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salesmanagement/Utils.dart';
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
  static Future<String> GetCustomerOlderStock(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetCustomerOlderStock/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  //Customer Cases
  static Future<String> GetCustomerCase(String caseId) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/CustomerCaseService.svc/GetCase/'+caseId);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> FindCustomerCases(String search) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/CustomerCaseService.svc/FindCases/'+search);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> DeleteCustomerCase(int recordId) async{
    final response = await http.delete('http://sales.arabianceramics.com/AcmcMobileServices/CustomerCaseService.svc/DeleteCase/'+recordId.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> CreateCustomerCase(String classField,String description,int statusField,int partyField,String caseCategoryField,int categoryTypeField,String priorityField) async{
//    Map<String,dynamic> bodyJson={
//      'classField':classField,
//      'descriptionField':description,
//      'statusField':statusField,
//      'partyField':partyField,
//      'priorityField':priorityField,
//      'categoryRecIdField':{'PropertyChanged':null,'caseCategoryField':caseCategoryField,'categoryTypeField':categoryTypeField},
//    };
    final body = jsonEncode({'classField':classField,
      'descriptionField':description,
      'statusField':statusField,
      'partyField':partyField,
      'priorityField':priorityField,
      'categoryRecIdField':{'PropertyChanged':null,'caseCategoryField':caseCategoryField,'categoryTypeField':categoryTypeField}},toEncodable: Utils.myEncode);
    final response = await http.post('http://sales.arabianceramics.com/AcmcMobileServices/CustomerCaseService.svc/CreateCase?caseDetail='+body);
    print(body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  //Production Plan
  static Future<String> GetItemSizes()async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetItemSizes');
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerPlan(String customerId,String year)async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlan/'+customerId+'/'+year);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerPlanBySize(String customerId,String size,String year)async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlanBySize/'+customerId+'/'+year+'/'+size);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetCustomerPlanByMonthSize(String customerId,String size,String year,int month)async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlanByMonthSize/'+customerId+'/'+year+'/'+month.toString()+'/'+size);
    print('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlanByMonthSize/'+customerId+'/'+year+'/'+month.toString()+'/'+size);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  //Production Request
  static Future<String> GetProdRequestList(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestList/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProdRequestListBySize(String CustomerId,String size,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestListBySize/'+CustomerId+'/'+size+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProdRequestListByItem(String CustomerId,String itemNumber,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestListByItem/'+CustomerId+'/'+itemNumber+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> DeleteProdRequest(String requestId) async{
    final response=await http.delete('http://sales.arabianceramics.com/AcmcMobileServices/DeleteProdRequest/'+requestId);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  //Production Schedule
  static Future<String> GetProductionSchedules(String CustomerId,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProductionSchedules/'+CustomerId+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProductionSchedulesByItem(String CustomerId,String itemNumber,int PageNo,int PageSize) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProductionSchedulesByItem/'+CustomerId+'/'+itemNumber+'/'+PageNo.toString()+'/'+PageSize.toString());
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> GetProductionScheduleByRequest(String requestId) async{
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdScheduleByRequest/'+requestId);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }

}