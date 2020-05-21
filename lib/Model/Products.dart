class Products{
  int id;
  String ItemName,ItemNumber,SizeItem,InventoryDimension,ColorItem,PickingId,Grade;

  Products(this.ItemName, this.ItemNumber, this.SizeItem,
      this.InventoryDimension, this.ColorItem, this.PickingId, this.Grade,
      this.SalesQuantity);

  double SalesQuantity;

  Map<String,dynamic> toMap()=>{
     "ItemName":ItemName,
      "ItemNumber":ItemNumber,
      "SizeItem":SizeItem,
     "InventoryDimension":InventoryDimension,
      "ColorItem":ColorItem,
      "PickingId":PickingId,
      "Grade":Grade,
      "SalesQuantity":SalesQuantity
  };
  Products.fromMap(Map<dynamic,dynamic> data){
    ItemName=data['ItemName'];
    ItemNumber=data['ItemNumber'];
    SizeItem=data['SizeItem'];
    ColorItem=data['ColorItem'];
    PickingId=data['PickingId'];
    Grade=data['Grade'];
    SalesQuantity=data['SalesQuantity'];
    InventoryDimension=data['InventoryDimension'];
  }
}