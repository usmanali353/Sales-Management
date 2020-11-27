import 'dart:convert';

class ProductionPlans {
  ProductionPlans({
    this.customerAccount,
    this.estimatedQuantity,
    this.itemSize,
    this.monthOfYear,
    this.recordId,
    this.whichYear,
  });

  String customerAccount;
  int estimatedQuantity;
  String itemSize;
  String monthOfYear;
  int recordId;
  int whichYear;
 static List<ProductionPlans> productionPlansFromJson(String str) => List<ProductionPlans>.from(json.decode(str).map((x) => ProductionPlans.fromJson(x)));

 static String productionPlansToJson(List<ProductionPlans> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory ProductionPlans.fromJson(Map<String, dynamic> json) => ProductionPlans(
    customerAccount: json["CustomerAccount"],
    estimatedQuantity: json["EstimatedQuantity"],
    itemSize: json["ItemSize"],
    monthOfYear: json["MonthOfYear"],
    recordId: json["RecordId"],
    whichYear: json["WhichYear"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerAccount": customerAccount,
    "EstimatedQuantity": estimatedQuantity,
    "ItemSize": itemSize,
    "MonthOfYear": monthOfYear,
    "RecordId": recordId,
    "WhichYear": whichYear,
  };
}
