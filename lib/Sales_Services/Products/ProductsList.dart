import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'ProductDetails.dart';

class ProductsList extends StatefulWidget{
  var products;

  ProductsList(this.products);

  @override
  State<StatefulWidget> createState() {
    return _ProductsList(products);
  }

}
class _ProductsList extends State<ProductsList>{
  var products,temp=['',''];

  _ProductsList(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ListView.builder(
        itemCount: products!=null?products['m_Item2'].length:temp.length,
          itemBuilder: (context,int index){
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(products!=null?products['m_Item2'][index]['ProductName']:''),
              leading: Icon(FontAwesomeIcons.box),
              onTap: (){
                print(products[index]);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(products['m_Item2'][index])));
              },
            ),
            Divider(),
          ],
        );
      }),
      );

  }

}