import 'dart:convert';

//List<Invoices> invoicesFromJson(String str) => List<Invoices>.from(json.decode(str).map((x) => Invoices.fromJson(x)));

//String invoicesToJson(List<Invoices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoices {
  Invoices({
    this.customerId,
    this.customerName,
    this.deliveryName,
    this.dueDate,
    this.invoiceAmount,
    this.invoiceDate,
    this.invoiceId,
    this.invoiceLines,
    this.quantitySold,
    this.salesAmount,
    this.salesOrderId,
    this.salesTaxAmount,
    this.settlementAmount,
    this.settlementDate,
    this.settlementDone,
    this.settlementVoucher,
  });

  String customerId;
  String customerName;
  String deliveryName;
  String dueDate;
  double invoiceAmount;
  String invoiceDate;
  String invoiceId;
  dynamic invoiceLines;
  dynamic quantitySold;
  dynamic salesAmount;
  String salesOrderId;
  dynamic salesTaxAmount;
  dynamic settlementAmount;
  String settlementDate;
  dynamic settlementDone;
  String settlementVoucher;
 static List<Invoices> invoicesFromJson(String str) => List<Invoices>.from(json.decode(str).map((x) => Invoices.fromJson(x)));
 static String invoicesToJson(List<Invoices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
    customerId: json["CustomerId"],
    customerName: json["CustomerName"],
    deliveryName: json["DeliveryName"],
    dueDate: json["DueDate"],
    invoiceAmount: json["InvoiceAmount"],
    invoiceDate: json["InvoiceDate"],
    invoiceId: json["InvoiceId"],
    invoiceLines: json["InvoiceLines"],
    quantitySold: json["QuantitySold"],
    salesAmount: json["SalesAmount"],
    salesOrderId: json["SalesOrderId"],
    salesTaxAmount: json["SalesTaxAmount"],
    settlementAmount: json["SettlementAmount"],
    settlementDate: json["SettlementDate"],
    settlementDone: json["SettlementDone"],
    settlementVoucher: json["SettlementVoucher"],
  );

  Map<String, dynamic> toJson() => {
    "CustomerId": customerId,
    "CustomerName": customerName,
    "DeliveryName": deliveryName,
    "DueDate": dueDate,
    "InvoiceAmount": invoiceAmount,
    "InvoiceDate": invoiceDate,
    "InvoiceId": invoiceId,
    "InvoiceLines": invoiceLines,
    "QuantitySold": quantitySold,
    "SalesAmount": salesAmount,
    "SalesOrderId": salesOrderId,
    "SalesTaxAmount": salesTaxAmount,
    "SettlementAmount": settlementAmount,
    "SettlementDate": settlementDate,
    "SettlementDone": settlementDone,
    "SettlementVoucher": settlementVoucher,
  };
}