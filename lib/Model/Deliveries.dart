import 'dart:convert';

class Deliveries {
  Deliveries({
    this.propertyChanged,
    this.barcodeCode128Field,
    this.customerIdField,
    this.customerNameField,
    this.deliveryAddressField,
    this.deliveryDateField,
    this.deliveryDateFieldSpecified,
    this.deliveryStatusField,
    this.deliveryStatusFieldSpecified,
    this.lineNumField,
    this.lineNumFieldSpecified,
    this.mobileField,
    this.packingSlipGenerateField,
    this.packingSlipGenerateFieldSpecified,
    this.packingSlipNumField,
    this.pickingIdField,
    this.quantityInPalletsField,
    this.quantityInSqmField,
    this.salesIdField,
    this.startLoadTruckField,
    this.startLoadTruckFieldSpecified,
    this.stopLoadTruckField,
    this.stopLoadTruckFieldSpecified,
    this.ticketField,
    this.truckDriverField,
    this.truckPlateNumField,
  });
 static List<Deliveries> deliveriesFromJson(String str) => List<Deliveries>.from(json.decode(str).map((x) => Deliveries.fromJson(x)));

 static String deliveriesToJson(List<Deliveries> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  dynamic propertyChanged;
  String barcodeCode128Field;
  String customerIdField;
  String customerNameField;
  String deliveryAddressField;
  String deliveryDateField;
  bool deliveryDateFieldSpecified;
  int deliveryStatusField;
  bool deliveryStatusFieldSpecified;
  int lineNumField;
  bool lineNumFieldSpecified;
  String mobileField;
  String packingSlipGenerateField;
  bool packingSlipGenerateFieldSpecified;
  String packingSlipNumField;
  String pickingIdField;
  String quantityInPalletsField;
  String quantityInSqmField;
  String salesIdField;
  String startLoadTruckField;
  bool startLoadTruckFieldSpecified;
  String stopLoadTruckField;
  bool stopLoadTruckFieldSpecified;
  String ticketField;
  String truckDriverField;
  String truckPlateNumField;

  factory Deliveries.fromJson(Map<String, dynamic> json) => Deliveries(
    propertyChanged: json["PropertyChanged"],
    barcodeCode128Field: json["barcode_Code128Field"],
    customerIdField: json["customerIdField"],
    customerNameField: json["customerNameField"],
    deliveryAddressField: json["deliveryAddressField"],
    deliveryDateField: json["deliveryDateField"],
    deliveryDateFieldSpecified: json["deliveryDateFieldSpecified"],
    deliveryStatusField: json["deliveryStatusField"],
    deliveryStatusFieldSpecified: json["deliveryStatusFieldSpecified"],
    lineNumField: json["lineNumField"],
    lineNumFieldSpecified: json["lineNumFieldSpecified"],
    mobileField: json["mobileField"],
    packingSlipGenerateField: json["packingSlipGenerateField"],
    packingSlipGenerateFieldSpecified: json["packingSlipGenerateFieldSpecified"],
    packingSlipNumField: json["packingSlipNumField"],
    pickingIdField: json["pickingIdField"],
    quantityInPalletsField: json["quantityInPalletsField"],
    quantityInSqmField: json["quantityInSQMField"],
    salesIdField: json["salesIdField"],
    startLoadTruckField: json["startLoadTruckField"],
    startLoadTruckFieldSpecified: json["startLoadTruckFieldSpecified"],
    stopLoadTruckField: json["stopLoadTruckField"],
    stopLoadTruckFieldSpecified: json["stopLoadTruckFieldSpecified"],
    ticketField: json["ticketField"],
    truckDriverField: json["truckDriverField"],
    truckPlateNumField: json["truckPlateNumField"],
  );

  Map<String, dynamic> toJson() => {
    "PropertyChanged": propertyChanged,
    "barcode_Code128Field": barcodeCode128Field,
    "customerIdField": customerIdField,
    "customerNameField": customerNameField,
    "deliveryAddressField": deliveryAddressField,
    "deliveryDateField": deliveryDateField,
    "deliveryDateFieldSpecified": deliveryDateFieldSpecified,
    "deliveryStatusField": deliveryStatusField,
    "deliveryStatusFieldSpecified": deliveryStatusFieldSpecified,
    "lineNumField": lineNumField,
    "lineNumFieldSpecified": lineNumFieldSpecified,
    "mobileField": mobileField,
    "packingSlipGenerateField": packingSlipGenerateField,
    "packingSlipGenerateFieldSpecified": packingSlipGenerateFieldSpecified,
    "packingSlipNumField": packingSlipNumField,
    "pickingIdField": pickingIdField,
    "quantityInPalletsField": quantityInPalletsField,
    "quantityInSQMField": quantityInSqmField,
    "salesIdField": salesIdField,
    "startLoadTruckField": startLoadTruckField,
    "startLoadTruckFieldSpecified": startLoadTruckFieldSpecified,
    "stopLoadTruckField": stopLoadTruckField,
    "stopLoadTruckFieldSpecified": stopLoadTruckFieldSpecified,
    "ticketField": ticketField,
    "truckDriverField": truckDriverField,
    "truckPlateNumField": truckPlateNumField,
  };
}
