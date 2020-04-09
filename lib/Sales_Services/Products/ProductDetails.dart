import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget{
  var productData;

  ProductDetails(this.productData);

  @override
  State<StatefulWidget> createState() {

    return _ProductDetails(productData);
  }

}
class _ProductDetails extends State<ProductDetails>{
  var productData;

  _ProductDetails(this.productData);
  @override
  void initState() {
    print(productData);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Product Detail"),),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text("Customer Ac #"),
                subtitle: Text(productData['CustomerAccount']!=null?productData['CustomerAccount']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Product Id"),
                subtitle: Text(productData['ItemNumber']!=null?productData['ItemNumber']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Product Name"),
                subtitle: Text(productData['ProductName']!=null?productData['ProductName']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Product Size"),
                subtitle: Text(productData['ItemSize']!=null?productData['ItemSize']:''),
              ),
              Divider(),
              ListTile(
                title: Text("Product Short Name"),
                subtitle: Text(productData['ShortDescription']!=null?productData['ShortDescription']:''),
              ),
              Divider(),
            ],
          )

        ],
      ),
    );
  }

}