import 'dart:convert';

List<CustomerCases> customerCasesFromJson(String str) => List<CustomerCases>.from(json.decode(str).map((x) => CustomerCases.fromJson(x)));

String customerCasesToJson(List<CustomerCases> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerCases {
  CustomerCases({
    this.caseDescription,
    this.caseMemo,
    this.caseNum,
    this.categoryTypeId,
    this.customerAccount,
    this.customerName,
    this.priority,
    this.resolutionType,
    this.status,
  });

  String caseDescription;
  String caseMemo;
  String caseNum;
  int categoryTypeId;
  String customerAccount;
  String customerName;
  String priority;
  int resolutionType;
  int status;

 static List<CustomerCases> customerCasesFromJson(String str) => List<CustomerCases>.from(json.decode(str).map((x) => CustomerCases.fromJson(x)));
 static CustomerCases customerCasesObjFromJson(String str) => CustomerCases.fromJson(json.decode(str));
 static String customerCasesToJson(List<CustomerCases> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory CustomerCases.fromJson(Map<String, dynamic> json) => CustomerCases(
    caseDescription: json["CaseDescription"],
    caseMemo: json["CaseMemo"],
    caseNum: json["CaseNum"],
    categoryTypeId: json["CategoryTypeId"],
    customerAccount: json["CustomerAccount"],
    customerName: json["CustomerName"],
    priority: json["Priority"],
    resolutionType: json["ResolutionType"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "CaseDescription": caseDescription,
    "CaseMemo": caseMemo,
    "CaseNum": caseNum,
    "CategoryTypeId": categoryTypeId,
    "CustomerAccount": customerAccount,
    "CustomerName": customerName,
    "Priority": priority,
    "ResolutionType": resolutionType,
    "Status": status,
  };
}
