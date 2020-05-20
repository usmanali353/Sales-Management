import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class newdashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _newdashboard();
  }

}

class _newdashboard extends State<newdashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
       appBar: AppBar(
         leading:  IconButton(
           icon: Icon(Icons.menu, color: Colors.white,size:32),
//                            onPressed: (){
//                              Navigator.pop(context);
//                            },
         ),
         backgroundColor:  Color(0xFF004c4c),
         titleSpacing: 100,
         title: Text("Dashboard", style: TextStyle(
           color: Colors.white
       ),
    ),

       ),
      body: Container(
        color: Colors.grey.shade100,
        margin: EdgeInsets.only(bottom: 15),
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Container(margin: EdgeInsets.only(left: 17),
                    child: Text("Deliveries", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),)
                ),
              ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF004c4c),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Today's\n(In SQM)",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),
                            color: Colors.grey.shade100,
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("21575.232",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),


                  ),
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF004c4c),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Weekly\n(In SQM)",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),
                            color: Colors.grey.shade100,
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("49402.888",
                              style: TextStyle(
                                  color:Colors.teal.shade800,
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),

                  ),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Container(margin: EdgeInsets.only(left: 17),
                  child: Text("Production Request", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),)
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Requested\n(In SQM)",
                            style: TextStyle(
                                color: Color(0xFF004c4c),
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),

                            color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  //spreadRadius: 1.0
                                ),
                              ]
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("17853",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Approved\nProduction",
                            style: TextStyle(
                                color: Color(0xFF004c4c),
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),

                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  //spreadRadius: 1.0
                                ),
                              ]
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("666500",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Container(
                margin: EdgeInsets.only(left: 12.5,right: 12.5),
                height: 130,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        // spreadRadius: 1.0
                      ),
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        //spreadRadius: 1.0
                      ),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: Text("Total Produced (In SQM)",
                        style: TextStyle(
                            color: Color(0xFF004c4c),
                          fontWeight: FontWeight.bold


                        ),
                      ),
                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10),
//                      color: Color(0xFF004c4c),
//                      height: 20,
//                      width: 100,
//                      child: Text("Customer Balance Amount",
//                          style: TextStyle(
//                            color: Colors.white
//                          ),
//                      ),
//                    ),
                    Container(
                      //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)
                        ),
                        color: Colors.grey.shade200,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: Offset(4.0, 4.0),
                              blurRadius: 15.0,
                              // spreadRadius: 1.0
                            ),
                            BoxShadow(
                              color: Colors.grey.shade100,
                              offset: Offset(-4.0, -4.0),
                              blurRadius: 15.0,
                              //spreadRadius: 1.0
                            ),
                          ]
                      ),
                      child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                        child: Text("3382300",
                          style: TextStyle(
                              color:Colors.teal.shade800,
                              //Color(0xFF004c4c),
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),

                        ),
                      ),
                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Container(margin: EdgeInsets.only(left: 17),
                  child: Text("Finance", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Container(
                margin: EdgeInsets.only(left: 12.5,right: 12.5),
                height: 130,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF004c4c),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        // spreadRadius: 1.0
                      ),
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15.0,
                        //spreadRadius: 1.0
                      ),
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text("Customer Balance Amount",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold

                            ),
                        ),
                  ),
//                    Container(
//                      margin: EdgeInsets.only(left: 10),
//                      color: Color(0xFF004c4c),
//                      height: 20,
//                      width: 100,
//                      child: Text("Customer Balance Amount",
//                          style: TextStyle(
//                            color: Colors.white
//                          ),
//                      ),
//                    ),
                    Container(
                      //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)
                        ),
                        color: Colors.grey.shade100,
                      ),
                      child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                        child: Text("6790410.0",
                          style: TextStyle(
                          color:Colors.teal.shade800,
                          //Color(0xFF004c4c),
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),

                        ),
                      ),
                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 17),
                      child: Text("Products", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),)
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("On-Hand\nStock\n(In SQM)",
                            style: TextStyle(
                                color: Color(0xFF004c4c),
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),

                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  //spreadRadius: 1.0
                                ),
                              ]
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("null",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),

                  ),
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Old Stock\n(In SQM)",
                            style: TextStyle(
                                color: Color(0xFF004c4c),
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),

                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade100,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  //spreadRadius: 1.0
                                ),
                              ]
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("1",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(margin: EdgeInsets.only(left: 17),
                      child: Text("Customer Complaints", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),)
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF9B3340),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("Opened",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold


                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                              ),

                              color: Colors.grey.shade200,
//                              boxShadow: [
//                                BoxShadow(
//                                  color: Colors.grey.shade400,
//                                  offset: Offset(4.0, 4.0),
//                                  blurRadius: 15.0,
//                                  // spreadRadius: 1.0
//                                ),
//                                BoxShadow(
//                                  color: Colors.grey.shade100,
//                                  offset: Offset(-4.0, -4.0),
//                                  blurRadius: 15.0,
//                                  //spreadRadius: 1.0
//                                ),
//                              ]
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5),
                            child: Text("4",
                              style: TextStyle(
                                  color:Color(0xFF9B3340),
                                  //Color(0xFF004c4c),
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 185,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF004c4c),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            // spreadRadius: 1.0
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            //spreadRadius: 1.0
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 12),
                          child: Text("In-process",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,



                            ),
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.only(left: 10, top: 5,bottom: 5),

                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)
                            ),
                            color: Colors.grey.shade100,
                          ),
                          child: Container(margin: EdgeInsets.only(left: 10,top: 5, bottom: 5),
                            child: Text("1",
                              style: TextStyle(
                                  color:Color(0xFF004c4c),
                                  //Color(0xFF004c4c),
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}