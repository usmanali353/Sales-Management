import 'dart:convert';

class DeliveryItems {
  DeliveryItems({
    this.propertyChanged,
    this.gradeField,
    this.itemIdField,
    this.nameField,
    this.palletsField,
    this.salesIdField,
    this.salesQtyBoxField,
    this.salesQtyBoxFieldSpecified,
    this.salesQtyField,
    this.salesQtyFieldSpecified,
    this.salesQtyPalletField,
    this.salesQtyPalletFieldSpecified,
    this.salesQtySqmField,
    this.salesQtySqmFieldSpecified,
    this.salesQtySqmRemainingField,
    this.salesQtySqmRemainingFieldSpecified,
    this.salesQtySqmReservedField,
    this.salesQtySqmReservedFieldSpecified,
    this.salesUnitField,
    this.serialField,
    this.shadeField,
    this.sizeField,
    this.wLocationIdField,
    this.warehouseField,
    this.warehouseLocationField,
    this.reservedPercentField,
    this.reservedQtyField
  });
  dynamic reservedQtyField;
  dynamic reservedPercentField;
  String warehouseLocationField;
  dynamic propertyChanged;
  dynamic gradeField;
  String itemIdField;
  String nameField;
  List<PalletsField> palletsField;
  String salesIdField;
  int salesQtyBoxField;
  bool salesQtyBoxFieldSpecified;
  double salesQtyField;
  bool salesQtyFieldSpecified;
  dynamic salesQtyPalletField;
  bool salesQtyPalletFieldSpecified;
  double salesQtySqmField;
  bool salesQtySqmFieldSpecified;
  double salesQtySqmRemainingField;
  bool salesQtySqmRemainingFieldSpecified;
  int salesQtySqmReservedField;
  bool salesQtySqmReservedFieldSpecified;
  String salesUnitField;
  String serialField;
  dynamic shadeField;
  dynamic sizeField;
  String wLocationIdField;
  String warehouseField;

  static DeliveryItems deliveryItemsObjectFromJson(String str) => DeliveryItems.fromJson(json.decode(str));

  factory DeliveryItems.fromJson(Map<String, dynamic> json) => DeliveryItems(
    propertyChanged: json["PropertyChanged"],
    gradeField: json["gradeField"],
    itemIdField: json["itemIdField"],
    nameField: json["nameField"],
    reservedPercentField: json["reservedPercentField"],
    reservedQtyField: json['reservedQtyField'],
    warehouseLocationField: json['warehouseLocationField'],
    palletsField:json["palletsField"]!=null?List<PalletsField>.from(json["palletsField"].map((x) => PalletsField.fromJson(x))):json["palletsField"],
    salesIdField: json["salesIdField"],
    salesQtyBoxField: json["salesQtyBoxField"],
    salesQtyBoxFieldSpecified: json["salesQtyBoxFieldSpecified"],
    salesQtyField: json["salesQtyField"],
    salesQtyFieldSpecified: json["salesQtyFieldSpecified"],
    salesQtyPalletField: json["salesQtyPalletField"],
    salesQtyPalletFieldSpecified: json["salesQtyPalletFieldSpecified"],
    salesQtySqmField: json["salesQtySQMField"],
    salesQtySqmFieldSpecified: json["salesQtySQMFieldSpecified"],
    salesQtySqmRemainingField: json["salesQtySQMRemainingField"],
    salesQtySqmRemainingFieldSpecified: json["salesQtySQMRemainingFieldSpecified"],
    salesQtySqmReservedField: json["salesQtySQMReservedField"],
    salesQtySqmReservedFieldSpecified: json["salesQtySQMReservedFieldSpecified"],
    salesUnitField: json["salesUnitField"],
    serialField: json["serialField"],
    shadeField: json["shadeField"],
    sizeField: json["sizeField"],
    wLocationIdField: json["wLocationIdField"],
    warehouseField: json["warehouseField"],
  );

  Map<String, dynamic> toJson() => {
    "PropertyChanged": propertyChanged,
    "gradeField": gradeField,
    "itemIdField": itemIdField,
    "nameField": nameField,
    //"palletsField": List<dynamic>.from(palletsField.map((x) => x.toJson())),
    "salesIdField": salesIdField,
    "salesQtyBoxField": salesQtyBoxField,
    "salesQtyBoxFieldSpecified": salesQtyBoxFieldSpecified,
    "salesQtyField": salesQtyField,
    "salesQtyFieldSpecified": salesQtyFieldSpecified,
    "salesQtyPalletField": salesQtyPalletField,
    "salesQtyPalletFieldSpecified": salesQtyPalletFieldSpecified,
    "salesQtySQMField": salesQtySqmField,
    "salesQtySQMFieldSpecified": salesQtySqmFieldSpecified,
    "salesQtySQMRemainingField": salesQtySqmRemainingField,
    "salesQtySQMRemainingFieldSpecified": salesQtySqmRemainingFieldSpecified,
    "salesQtySQMReservedField": salesQtySqmReservedField,
    "salesQtySQMReservedFieldSpecified": salesQtySqmReservedFieldSpecified,
    "salesUnitField": salesUnitField,
    "serialField": serialField,
    "shadeField": shadeField,
    "sizeField": sizeField,
    "wLocationIdField": wLocationIdField,
    "warehouseField": warehouseField,
  };

}
class PalletsField {
  PalletsField({
    this.propertyChanged,
    this.gradeField,
    this.salesQtyField,
    this.salesQtyFieldSpecified,
    this.serialField,
    this.shadeField,
    this.sizeField,
    this.warehouseField,
  });

  dynamic propertyChanged;
  dynamic gradeField;
  double salesQtyField;
  bool salesQtyFieldSpecified;
  String serialField;
  dynamic shadeField;
  dynamic sizeField;
  dynamic warehouseField;

  factory PalletsField.fromJson(Map<String, dynamic> json) => PalletsField(
    propertyChanged: json["PropertyChanged"],
    gradeField: json["gradeField"],
    salesQtyField: json["salesQtyField"].toDouble(),
    salesQtyFieldSpecified: json["salesQtyFieldSpecified"],
    serialField: json["serialField"],
    shadeField: json["shadeField"],
    sizeField: json["sizeField"],
    warehouseField: json["warehouseField"],
  );

  Map<String, dynamic> toJson() => {
    "PropertyChanged": propertyChanged,
    "gradeField": gradeField,
    "salesQtyField": salesQtyField,
    "salesQtyFieldSpecified": salesQtyFieldSpecified,
    "serialField": serialField,
    "shadeField": shadeField,
    "sizeField": sizeField,
    "warehouseField": warehouseField,
  };
}