import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:salesmanagement/Utils.dart';

class Network_Operations {
  static String username = 'AcmcUser';
  static String password = 'Aujc?468';
  static String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  static Future<String> find_orders(BuildContext context,String order_number) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/FindSalesOrder/' + order_number, headers: {'authorization': Utils.apiAuthentication()});
      print(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }
    return null;
  }
  static Future<String> get_deliveries(BuildContext context,String date, String CustomerId) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetDeliveries/' + CustomerId + '/' + date,
          headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }
    return null;
  }
  static Future<String> GetSalesOrders(BuildContext context,String start_date, String end_date, String CustomerId) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetSalesOrders/' +
          CustomerId +
          '/' +
          start_date +
          '/' +
          end_date,
          headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      print(e);
    }
   return null;
  }
  static Future<String> GetCustomerOnHand(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
  ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustomerOnHand/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context, e.toString());
    }

  }
  static Future<String> GetCustomerOnHandNoStock(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustomerOnHandNoStock/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetOnHandByItem(BuildContext context,String itemNumber) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetOnHandByItem/' +
          itemNumber,
          headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }
  }
  static Future<String> GetCustomerInvoices(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetInvoices/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetInvoice(BuildContext context,String InvoiceId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetInvoice/' + InvoiceId, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetProductInfo(BuildContext context,String itemNumber) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetProductInfo/' + itemNumber, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetProductsByModel(BuildContext context,String CustomerId, String model, String sort, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetProductsByModel/' +
          CustomerId +
          '/' +
          model +
          '/' +
          sort +
          '/' +
          PageNo.toString() +
          '/' +
          PageSize.toString(),
          headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetProductsBySize(BuildContext context,String CustomerId, String size, String sort, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetProductsBySize/' +
          CustomerId +
          '/' +
          size +
          '/' +
          sort +
          '/' +
          PageNo.toString() +
          '/' +
          PageSize.toString(),
          headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
       Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context, e.toString());
    }

  }
  static Future<String> GetCustomerOlderStock(BuildContext context,String CustomerId) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustomerOlderStockOverAll/' + CustomerId+'/_', headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }

  }

  //Customer Cases
  static Future<String> GetCustomerCase(BuildContext context,String caseId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'CustomerCaseService.svc/GetCase/' + caseId, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
       pd.hide();
       Utils.showError(context,e.toString());
    }
  }
  static Future<String> FindCustomerCases(BuildContext context,String customerId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'CustomerCaseService.svc/FindCases/' +
          customerId,
          headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> DeleteCustomerCase(BuildContext context,String caseId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.delete(Utils.getBaseUrl()+'CustomerCaseService.svc/DeleteCase/' + caseId, headers: {'authorization': Utils.apiAuthentication()});
      //print(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> CreateCustomerCase(BuildContext context, String customerId, String description, int statusField, int categoryTypeField, customerName, int resolutionType, String caseMemo) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final body = jsonEncode({
        'CustomerAccount': customerId,
        'CustomerName': customerName,
        'CaseDescription': description,
        'CaseMemo': caseMemo,
        'Status': statusField,
        'ResolutionType': resolutionType,
        'CategoryTypeId': categoryTypeField
      }, toEncodable: Utils.myEncode);
      final response = await http.post(
          Utils.getBaseUrl()+'CustomerCaseService.svc/CreateCase',
          body: body,
          headers: {
            'authorization': Utils.apiAuthentication(),
            'Content-Type': 'application/json'
          });
      //print(response.statusCode);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
       Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context, e.toString());
    }

  }
  static Future<String> UpdateCustomerCase(BuildContext context, String caseId, String customerId, String description, int statusField, int categoryTypeField, customerName, int resolutionType, String caseMemo) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final body = jsonEncode({
        'CustomerAccount': customerId,
        'CustomerName': customerName,
        'CaseDescription': description,
        'CaseMemo': caseMemo,
        'Status': statusField,
        'ResolutionType': resolutionType,
        'CategoryTypeId': categoryTypeField
      }, toEncodable: Utils.myEncode);
      print(body);
      final response = await http.put(
          Utils.getBaseUrl()+'CustomerCaseService.svc/UpdateCase/' +
              caseId,
          body: body,
          headers: {
            'authorization': Utils.apiAuthentication(),
            'Content-Type': 'application/json'
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  //Production Plan
  static Future<String> GetItemSizes(BuildContext context) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetItemSizes', headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }

  static Future<String> GetCustomerPlan(BuildContext context,String customerId, String year) async {
     ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetCustomerPlan/' + customerId + '/' + year, headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetCustomerPlanForecast(String customerId, int year,int month) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetMonthlyForcastSummary/' + customerId + '/' + year.toString() + '/' + month.toString(), headers: {'authorization': basicAuth});
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetCustomerPlanBySize(
      String customerId, String size, String year) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlanBySize/' +
            customerId +
            '/' +
            year +
            '/' +
            size,
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetCustomerPlanByMonthSize(
      String customerId, String size, String year, int month) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/GetCustomerPlanByMonthSize/' +
            customerId +
            '/' +
            year +
            '/' +
            month.toString() +
            '/' +
            size,
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> DeleteCustomerPlan(int recId) async {
    final response = await http.delete(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/DeleteCustomerPlan/' +
            recId.toString(),
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> CreateCustomerPlan(
      String customerAccount,
      String itemSize,
      int monthOfYear,
      int whichYear,
      int requestedQuantity) async {
    final body = jsonEncode({
      'CustomerAccount': customerAccount,
      'ItemSize': itemSize,
      'EstimatedQuantity': requestedQuantity,
      'MonthOfYear': monthOfYear,
      'WhichYear': whichYear,
    });
    final response = await http.post(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/CreateCustomerPlan',
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: body);
    //print(response.body);
    //print(body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> UpdateCustomerPlan(
      String customerAccount,
      String itemSize,
      int monthOfYear,
      int whichYear,
      int requestedQuantity,
      int recordId) async {
    final body = jsonEncode({
      'CustomerAccount': customerAccount,
      'ItemSize': itemSize,
      'EstimatedQuantity': requestedQuantity,
      'MonthOfYear': monthOfYear,
      'WhichYear': whichYear,
    });
    final response = await http.put(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdPlanService.svc/UpdateCustomerPlan/' +
            recordId.toString(),
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: body);
    //print(response.body);
    //print(body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  //Production Request
  static Future<String> GetProdRequestList(
      String CustomerId, int PageNo, int PageSize) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestList/' +
            CustomerId +
            '/' +
            PageNo.toString() +
            '/' +
            PageSize.toString(),
        headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetProdRequestListBySize(
      String CustomerId, String size, int PageNo, int PageSize) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestListBySize/' +
            CustomerId +
            '/' +
            size +
            '/' +
            PageNo.toString() +
            '/' +
            PageSize.toString(),
        headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetProdRequestListByItem(
      String CustomerId, String itemNumber, int PageNo, int PageSize) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestListByItem/' +
            CustomerId +
            '/' +
            itemNumber +
            '/' +
            PageNo.toString() +
            '/' +
            PageSize.toString(),
        headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> DeleteProdRequest(String requestId) async {
    final response = await http.delete(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/DeleteProdRequest/' +
            requestId,
        headers: {'authorization': basicAuth});
    //print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> CreateProductionRequest(
      String customerAccount,
      String itemNumber,
      String customerItemCode,
      int productionMonth,
      int requestedQuantity,
      String itemSize) async {
    final body = jsonEncode({
      'CustomerAccount': customerAccount,
      'ItemNumber': itemNumber,
      'ItemSize':itemSize,
      'CustomerItemCode': customerItemCode,
      'ProductionMonth': productionMonth,
      'QuantityRequested': requestedQuantity,
      'RequestedDate': '/Date(' +
          new DateTime.now().millisecondsSinceEpoch.toString() +
          '+0300)/'
    }, toEncodable: Utils.myEncode);
    final response = await http.post(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/CreateProdRequest',
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: body);
    //print(response.statusCode);
    //print(body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> UpdateProductionRequest(
      String customerAccount,
      String itemNumber,
      String customerItemCode,
      int productionMonth,
      int requestedQuantity,
      String requestDate,
      String customerPoNumber,
      String productionRequestId) async {
    final body = jsonEncode({
      'ProductionRequestId': productionRequestId,
      'CustomerAccount': customerAccount,
      'ItemNumber': itemNumber,
      'CustomerItemCode': customerItemCode,
      'ProductionMonth': productionMonth,
      'QuantityRequested': requestedQuantity,
      'RequestedDate': requestDate,
      'CustomerPONum': customerPoNumber
    }, toEncodable: Utils.myEncode);
    final response = await http.put(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/UpdateProdRequest/' +
            productionRequestId,
        headers: {
          'authorization': basicAuth,
          'Content-Type': 'application/json'
        },
        body: body);
    //print(response.statusCode);
    //print(body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  //Production Schedule
  static Future<String> GetProductionSchedules(
      String CustomerId, int PageNo, int PageSize) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProductionSchedules/' +
            CustomerId +
            '/' +
            PageNo.toString() +
            '/' +
            PageSize.toString(),
        headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetProductionSchedulesByItem(
      String CustomerId, String itemNumber, int PageNo, int PageSize) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProductionSchedulesByItem/' +
            CustomerId +
            '/' +
            itemNumber +
            '/' +
            PageNo.toString() +
            '/' +
            PageSize.toString(),
        headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetProductionScheduleByRequest(String requestId) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdScheduleByRequest/' +
            requestId,
        headers: {'authorization': basicAuth});
    //debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> getCasesSummary(String CustomerId) async {
    final response = await http.get(
          'http://sales.arabianceramics.com/AcmcMobileServices/SummaryService.svc/SummaryCases/' +
              CustomerId,
          headers: {'authorization': basicAuth});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        return null;
  }

  static Future<String> getProductionRequestsSummary(String CustomerId) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/SummaryService.svc/SummaryProductionRequests/' +
            CustomerId,
        headers: {'authorization': basicAuth});
     //debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetDeliveryDailySummary(String CustomerId, String date) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/SummaryService.svc/GetDeliveryDailySummary/' +
            CustomerId +
            '/' +
            date,
        headers: {'authorization': basicAuth});
     debugPrint('Daily Delivery Summary '+response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetDeliveryInDatesSummary(
      String CustomerId, String startDate, String endDate) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/SummaryService.svc/GetDeliveryInDatesSummary/' +
            CustomerId +
            '/' +
            startDate +
            '/' +
            endDate,
        headers: {'authorization': basicAuth});
    debugPrint('GetDeliveryInDatesSummary'+response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }

  static Future<String> GetCustomerBalanceOnhand(String customerId) async {
    final response = await http.get(
        'http://sales.arabianceramics.com/AcmcMobileServices/SummaryService.svc/CustOutstandingBalance/' +
            customerId,
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> GetOnhandStock(String customerId) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/GetOnhandStock/'+customerId, headers: {'authorization': basicAuth});
   // debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> GetOpenPickingLists(String customerId,String itemNumber) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetOpenPickingLists/'+customerId+'/'+itemNumber, headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> GetOnhandStockByItem(String customerId,String itemNumber) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/GetOnhandStockByItemWithOrdered/'+customerId+'/'+itemNumber, headers: {'authorization': basicAuth});
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> GetProdRequestListByItemNotFinished(String customerId,String itemNumber,int pageNo,int pageSize) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/ProdRequestService.svc/GetProdRequestListByItemNotFinished/'+customerId+'/'+itemNumber+'/'+pageNo.toString()+'/'+pageSize.toString(), headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> GetAllPrePicking(String customerId) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/GetAllPrePickings/'+customerId, headers: {'authorization': basicAuth});
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> DeletePrePicking(String pickingId) async {
    final response = await http.delete('http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/DeletePrePicking/'+pickingId, headers: {'authorization': basicAuth});
    //print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> CreatePrePicking(String customerAccount,String address,String driverName,String truckNumber,String deliveryDate,String mobileNum,List<Map> prePickingLines)async{
    final body = jsonEncode({
      'CustomerAccount': customerAccount,
      'Address': address,
      'HasSameDimension':0,
      'Status': 0,
      'DriverName': driverName,
      'TruckPlate': truckNumber,
      'DeliveryDate': deliveryDate,
      'MobileNum': mobileNum,
      'PrePickingLines': prePickingLines,
      'SalesID':''
    });
    final response= await http.post("http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/CreatePrePicking",headers:{'authorization': basicAuth,'Content-type':'application/json'},body: body);
//    debugPrint(response.body);
//    debugPrint(body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
  static Future<String> updatePrePicking(String customerAccount,String address,String driverName,String truckNumber,String deliveryDate,String mobileNum,List<Map> prePickingLines,String pickingId)async{
    final body = jsonEncode({
      'CustomerAccount': customerAccount,
      'Address': address,
      'HasSameDimension':0,
      'Status': 0,
      'DriverName': driverName,
      'TruckPlate': truckNumber,
      'DeliveryDate': deliveryDate,
      'MobileNum': mobileNum,
      'PrePickingLines': prePickingLines,
      'SalesID':''
    });
    final response= await http.put("http://sales.arabianceramics.com/AcmcMobileServices/PrePickingService.svc/UpdatePrePicking/"+pickingId,headers:{'authorization': basicAuth,'Content-type':'application/json'},body: body);
    //debugPrint(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else
      return null;
  }
}
