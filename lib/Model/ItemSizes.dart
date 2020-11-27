import 'dart:convert';

class ItemSizes {
  ItemSizes({
    this.backGroundColor,
    this.foreColor,
    this.itemSize,
  });

  String backGroundColor;
  dynamic foreColor;
  String itemSize;
  static List<ItemSizes> itemSizesFromJson(String str) => List<ItemSizes>.from(json.decode(str).map((x) => ItemSizes.fromJson(x)));

  static String itemSizesToJson(List<ItemSizes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  factory ItemSizes.fromJson(Map<String, dynamic> json) => ItemSizes(
    backGroundColor: json["BackGroundColor"],
    foreColor: json["ForeColor"],
    itemSize: json["ItemSize"],
  );

  Map<String, dynamic> toJson() => {
    "BackGroundColor": backGroundColor,
    "ForeColor": foreColor,
    "ItemSize": itemSize,
  };
}