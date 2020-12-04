import 'dart:convert';
class ProductionSchedule {
  ProductionSchedule({
    this.actualProdDate,
    this.actualProductionQuantity,
    this.classification,
    this.glazingType,
    this.itemDescription,
    this.itemNumber,
    this.ppaNumber,
    this.packageName,
    this.plannedProdDate,
    this.productionDays,
    this.productionLine,
    this.quantityRequested,
    this.scheduleStatus,
  });

  String actualProdDate;
  int actualProductionQuantity;
  String classification;
  String glazingType;
  String itemDescription;
  String itemNumber;
  String ppaNumber;
  String packageName;
  String plannedProdDate;
  int productionDays;
  String productionLine;
  int quantityRequested;
  String scheduleStatus;
  static List<ProductionSchedule> productionScheduleFromJson(String str) => List<ProductionSchedule>.from(json.decode(str).map((x) => ProductionSchedule.fromJson(x)));
  static ProductionSchedule productionScheduleObjectFromJson(String str) => ProductionSchedule.fromJson(json.decode(str));
  static String productionScheduleToJson(List<ProductionSchedule> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory ProductionSchedule.fromJson(Map<String, dynamic> json) => ProductionSchedule(
    actualProdDate: json["ActualProdDate"],
    actualProductionQuantity: json["ActualProductionQuantity"],
    classification: json["Classification"],
    glazingType: json["GlazingType"],
    itemDescription: json["ItemDescription"],
    itemNumber: json["ItemNumber"],
    ppaNumber: json["PPANumber"],
    packageName: json["PackageName"],
    plannedProdDate: json["PlannedProdDate"],
    productionDays: json["ProductionDays"],
    productionLine: json["ProductionLine"],
    quantityRequested: json["QuantityRequested"],
    scheduleStatus: json["ScheduleStatus"],
  );

  Map<String, dynamic> toJson() => {
    "ActualProdDate": actualProdDate,
    "ActualProductionQuantity": actualProductionQuantity,
    "Classification": classification,
    "GlazingType": glazingType,
    "ItemDescription": itemDescription,
    "ItemNumber": itemNumber,
    "PPANumber": ppaNumber,
    "PackageName": packageName,
    "PlannedProdDate": plannedProdDate,
    "ProductionDays": productionDays,
    "ProductionLine": productionLine,
    "QuantityRequested": quantityRequested,
    "ScheduleStatus": scheduleStatus,
  };
}