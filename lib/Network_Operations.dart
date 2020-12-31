import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:acmc_customer/Model/CustomerCases.dart';
import 'package:acmc_customer/Model/DeliveryItems.dart';
import 'package:acmc_customer/Model/ItemSizes.dart';
import 'package:acmc_customer/Model/ProductionPlans.dart';
import 'package:acmc_customer/Model/ProductionSchedule.dart';
import 'package:acmc_customer/Utils.dart';
import 'package:acmc_customer/Model/Invoices.dart';

import 'Model/Deliveries.dart';

class Network_Operations {
  //Login
  static Future<String> login(String mode,BuildContext context,String username,String password)async{
    ProgressDialog pd=ProgressDialog(context);
    String url;
    try{
      pd.show();
      if(mode=="Testing"){
        url="http://mobileapi.arabian-ceramics.com/ACMCMobileServices/";
      }else if(mode=="Live"){
        url="http://mobileapi.arabian-ceramics.com/ACMCMobileServicesLive/";
      }
      print(url);
      final response = await http.get(url+'userinfoservice.svc/LoginUser/'+ username+"/"+password, headers: {'authorization': Utils.apiAuthentication()});
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
    }finally{
      pd.hide();
    }
  }
  static Future<String> getUserInfo(BuildContext context,String username,String password)async{
    try{
      final response = await http.get(Utils.getBaseUrl()+'userinfoservice.svc/GetUserInfoOnLogin/'+ username+"/"+password, headers: {'authorization': Utils.apiAuthentication()});
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
  static Future<List<Deliveries>> get_deliveries(BuildContext context,String date, String CustomerId) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustomerDeliveries/'+ CustomerId +'/'+ date, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return Deliveries.deliveriesFromJson(response.body);
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }
    return null;
  }
  static Future<DeliveryItems> getPalletInfo(BuildContext context,String palletId)async
  {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetPalletInfo/'+ palletId, headers: {'authorization': Utils.apiAuthentication()});
      debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return DeliveryItems.deliveryItemsObjectFromJson(response.body);
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
  static Future<Deliveries> getDeliveryByPickingId(BuildContext context,String pickingId) async {
    ProgressDialog pd= ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetSingleDelivery/'+ pickingId, headers: {'authorization': Utils.apiAuthentication()});
      debugPrint(Utils.getBaseUrl()+'SalesService.svc/GetSingleDelivery/'+ pickingId);
      if (response.statusCode == 200) {
        pd.hide();
        return Deliveries.deliveriesObjectFromJson(response.body);
      } else
        pd.hide();
      Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      pd.hide();
      debugPrint(e.toString());
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
      debugPrint(response.body);
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
  static Future<List<Invoices>> GetCustomerInvoices(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetInvoices/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return Invoices.invoicesFromJson(response.body);
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
  static Future<List<Invoices>> GetCustInvoicesByDate(BuildContext context,String date,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustInvoicesByDate/'+CustomerId + '/'+date.replaceAll("00:00:00.000","")+'/'+ PageNo.toString() +'/'+PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return Invoices.invoicesFromJson(response.body);
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
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetCustomerOlderStockOverAll/' + CustomerId+'/_', headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetCustomerOlderStockDashboard(BuildContext context,String CustomerId) async {
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
  static Future<CustomerCases> GetCustomerCase(BuildContext context,String caseId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'CustomerCaseService.svc/GetCase/' + caseId, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return CustomerCases.customerCasesObjFromJson(response.body);
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
       pd.hide();
       Utils.showError(context,e.toString());
    }
  }
  static Future<List<CustomerCases>> FindCustomerCases(BuildContext context,String customerId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'CustomerCaseService.svc/FindCases/' +
          customerId,
          headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return CustomerCases.customerCasesFromJson(response.body);
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
  static Future<List<ItemSizes>> GetItemSizes(BuildContext context) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetItemSizes', headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        pd.hide();
        return ItemSizes.itemSizesFromJson(response.body);
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<List<ProductionPlans>> GetCustomerPlan(BuildContext context,String customerId, String year) async {
     ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetCustomerPlan/' + customerId + '/' + year, headers: {'authorization': Utils.apiAuthentication()});

      if (response.statusCode == 200) {
        pd.hide();
        return ProductionPlans.productionPlansFromJson(response.body);
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      pd.hide();
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetCustomerPlanForecast(BuildContext context,String customerId, int year,int month) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetMonthlyForcastSummary/' + customerId + '/' + year.toString() + '/' + month.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<List<ProductionPlans>> GetCustomerPlanBySize(BuildContext context,String customerId, String size, String year) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetCustomerPlanBySize/' + customerId + '/' + year + '/' + size,headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return ProductionPlans.productionPlansFromJson(response.body);
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetCustomerPlanByMonthSize(BuildContext context,String customerId, String size, String year, int month) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdPlanService.svc/GetCustomerPlanByMonthSize/' + customerId + '/' + year + '/' + month.toString() + '/' + size, headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }
  }
  static Future<String> DeleteCustomerPlan(BuildContext context,int recId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.delete(Utils.getBaseUrl()+'ProdPlanService.svc/DeleteCustomerPlan/' + recId.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }
  }
  static Future<String> CreateCustomerPlan(BuildContext context,String customerAccount, String itemSize, int monthOfYear, int whichYear, int requestedQuantity) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final body = jsonEncode({
        'CustomerAccount': customerAccount,
        'ItemSize': itemSize,
        'EstimatedQuantity': requestedQuantity,
        'MonthOfYear': monthOfYear,
        'WhichYear': whichYear,
      });
      final response = await http.post(
          Utils.getBaseUrl()+'ProdPlanService.svc/CreateCustomerPlan',
          headers: {
            'authorization': Utils.apiAuthentication(),
            'Content-Type': 'application/json'
          },
          body: body);
      //print(response.body);
      //print(body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> UpdateCustomerPlan(BuildContext context,String customerAccount, String itemSize, int monthOfYear, int whichYear, int requestedQuantity, int recordId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final body = jsonEncode({
        'CustomerAccount': customerAccount,
        'ItemSize': itemSize,
        'EstimatedQuantity': requestedQuantity,
        'MonthOfYear': monthOfYear,
        'WhichYear': whichYear,
      });
      final response = await http.put(
          Utils.getBaseUrl()+'ProdPlanService.svc/UpdateCustomerPlan/' +
              recordId.toString(),
          headers: {
            'authorization': Utils.apiAuthentication(),
            'Content-Type': 'application/json'
          },
          body: body);
      //print(response.body);
      //print(body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  //Production Request
  static Future<String> GetProdRequestList(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'/ProdRequestService.svc/GetProdRequestList/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetProdRequestListBySize(BuildContext context,String CustomerId, String size, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProdRequestListBySize/' + CustomerId + '/' + size + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }
  }
  static Future<String> GetProdRequestListByItem(BuildContext context,String CustomerId, String itemNumber, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProdRequestListByItem/' + CustomerId + '/' + itemNumber + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> DeleteProdRequest(BuildContext context,String requestId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.delete(Utils.getBaseUrl()+'ProdRequestService.svc/DeleteProdRequest/' +
          requestId,
          headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> CreateProductionRequest(BuildContext context,String customerAccount, String itemNumber, String customerItemCode, int productionMonth, int requestedQuantity, String itemSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
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
      final response = await http.post(Utils.getBaseUrl()+'ProdRequestService.svc/CreateProdRequest',
          headers: {
            'authorization': Utils.apiAuthentication(),
            'Content-Type': 'application/json'
          },
          body: body);
      //print(response.statusCode);
      //print(body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        return response.statusCode.toString();
    }catch(e){
       Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> UpdateProductionRequest(BuildContext context, String customerAccount, String itemNumber, String customerItemCode, int productionMonth, int requestedQuantity, String requestDate, String customerPoNumber, String productionRequestId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
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
      final response = await http.put(Utils.getBaseUrl()+'ProdRequestService.svc/UpdateProdRequest/'+ productionRequestId, headers: {'authorization': Utils.apiAuthentication(), 'Content-Type': 'application/json'},body: body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  //Production Schedule
  static Future<List<ProductionSchedule>> GetProductionSchedules(BuildContext context,String CustomerId, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProductionSchedules/' + CustomerId + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //print(response.body);
      if (response.statusCode == 200) {
        return ProductionSchedule.productionScheduleFromJson(response.body);
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;

    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<List<ProductionSchedule>> GetProductionSchedulesByItem(BuildContext context,String CustomerId, String itemNumber, int PageNo, int PageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProductionSchedulesByItem/' + CustomerId + '/' + itemNumber + '/' + PageNo.toString() + '/' + PageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      //print(response.body);
      if (response.statusCode == 200) {
        return ProductionSchedule.productionScheduleFromJson(response.body);
      } else
        Utils.showError(context,response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<ProductionSchedule> GetProductionScheduleByRequest(BuildContext context,String requestId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProdScheduleByRequest/' + requestId, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        return ProductionSchedule.productionScheduleObjectFromJson(response.body);
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }
  }
  //Summary
  static Future<String> getCasesSummary(BuildContext context,String CustomerId) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SummaryService.svc/SummaryCases/' + CustomerId, headers: {'authorization': Utils.apiAuthentication()});
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
  static Future<String> getProductionRequestsSummary(BuildContext context,String CustomerId) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SummaryService.svc/SummaryProductionRequests/' + CustomerId, headers: {'authorization': Utils.apiAuthentication()});
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetDeliveryDailySummary(BuildContext context,String CustomerId, String date) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SummaryService.svc/GetDeliveryDailySummary/' + CustomerId + '/' + date, headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetDeliveryInDatesSummary(BuildContext context,String CustomerId, String startDate, String endDate) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SummaryService.svc/GetDeliveryInDatesSummary/' + CustomerId + '/' + startDate + '/' + endDate, headers: {'authorization': Utils.apiAuthentication()});
      debugPrint('GetDeliveryInDatesSummary'+response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }

  }
  static Future<String> GetCustomerBalanceOnhand(BuildContext context,String customerId) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SummaryService.svc/CustOutstandingBalance/' + customerId, headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }

  }
  //PrePicking
  static Future<String> GetOnhandStock(BuildContext context,String customerId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'PrePickingService.svc/GetOnhandStock/'+customerId, headers: {'authorization': Utils.apiAuthentication()});
      // debugPrint(response.body);
      if (response.statusCode == 200) {
        pd.hide();
        return response.body;
      } else
        pd.hide();
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetOpenPickingLists(BuildContext context,String customerId,String itemNumber) async {
    try{
      final response = await http.get(Utils.getBaseUrl()+'SalesService.svc/GetOpenPickingLists/'+customerId+'/'+itemNumber, headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }

  }
  static Future<String> GetOnhandStockByItem(BuildContext context,String customerId,String itemNumber) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'PrePickingService.svc/GetOnhandStockByItemWithOrdered/'+customerId+'/'+itemNumber, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context,e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetProdRequestListByItemNotFinished(BuildContext context,String customerId,String itemNumber,int pageNo,int pageSize) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'ProdRequestService.svc/GetProdRequestListByItemNotFinished/'+customerId+'/'+itemNumber+'/'+pageNo.toString()+'/'+pageSize.toString(), headers: {'authorization': Utils.apiAuthentication()});
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> GetAllPrePicking(BuildContext context,String customerId) async {
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
      final response = await http.get(Utils.getBaseUrl()+'PrePickingService.svc/GetAllPrePickings/'+customerId, headers: {'authorization': Utils.apiAuthentication()});
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }

  }
  static Future<String> DeletePrePicking(BuildContext context,String pickingId) async {
    try{
      final response = await http.delete(Utils.getBaseUrl()+'PrePickingService.svc/DeletePrePicking/'+pickingId, headers: {'authorization': Utils.apiAuthentication()});
      //print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }

  }
  static Future<String> CreatePrePicking(BuildContext context,String customerAccount,String address,String driverName,String truckNumber,String deliveryDate,String mobileNum,List<Map> prePickingLines)async{
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
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
      final response= await http.post(Utils.getBaseUrl()+"PrePickingService.svc/CreatePrePicking",headers:{'authorization': Utils.apiAuthentication(),'Content-type':'application/json'},body: body);
//    debugPrint(response.body);
//    debugPrint(body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context,response.statusCode.toString());
      return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }


  }
  static Future<String> updatePrePicking(BuildContext context,String customerAccount,String address,String driverName,String truckNumber,String deliveryDate,String mobileNum,List<Map> prePickingLines,String pickingId)async{
    ProgressDialog pd=ProgressDialog(context);
    try{
      pd.show();
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
      final response= await http.put(Utils.getBaseUrl()+"PrePickingService.svc/UpdatePrePicking/"+pickingId,headers:{'authorization': Utils.apiAuthentication(),'Content-type':'application/json'},body: body);
      //debugPrint(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else
        Utils.showError(context, response.statusCode.toString());
        return null;
    }catch(e){
      Utils.showError(context, e.toString());
    }finally{
      pd.hide();
    }
  }
}
