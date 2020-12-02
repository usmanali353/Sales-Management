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
  });

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
  int salesQtyPalletField;
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

  factory DeliveryItems.fromJson(Map<String, dynamic> json) => DeliveryItems(
    propertyChanged: json["PropertyChanged"],
    gradeField: json["gradeField"],
    itemIdField: json["itemIdField"],
    nameField: json["nameField"],
    palletsField: List<PalletsField>.from(json["palletsField"].map((x) => PalletsField.fromJson(x))),
    salesIdField: json["salesIdField"],
    salesQtyBoxField: json["salesQtyBoxField"],
    salesQtyBoxFieldSpecified: json["salesQtyBoxFieldSpecified"],
    salesQtyField: json["salesQtyField"].toDouble(),
    salesQtyFieldSpecified: json["salesQtyFieldSpecified"],
    salesQtyPalletField: json["salesQtyPalletField"],
    salesQtyPalletFieldSpecified: json["salesQtyPalletFieldSpecified"],
    salesQtySqmField: json["salesQtySQMField"].toDouble(),
    salesQtySqmFieldSpecified: json["salesQtySQMFieldSpecified"],
    salesQtySqmRemainingField: json["salesQtySQMRemainingField"].toDouble(),
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
    "palletsField": List<dynamic>.from(palletsField.map((x) => x.toJson())),
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