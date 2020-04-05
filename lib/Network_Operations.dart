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
  static Future<String> get_deliveries(String date) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetDeliveries//LC0001/'+date);
    print(response.body);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }
  static Future<String> get_orders_array_second_link(String start_date,String end_date) async {
    final response = await http.get('http://sales.arabianceramics.com/AcmcMobileServices/SalesService.svc/GetSalesOrders/LC0004/'+start_date+"/"+end_date);
    if(response.statusCode==200) {
      return response.body;
    }else
      return null;
  }

}