import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDashboard extends StatefulWidget {
  @override
  _NewDashboardState createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFF004c4c)
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        children: <Widget>[

                          Container(
                            height: 40,
                            width: 500,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            color: Color(0xFF004c4c),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.dehaze, color: Colors.white,size:32),
//                            onPressed: (){
//                              Navigator.pop(context);
//                            },
                                ),
                                IconButton(
                                  icon: Icon(Icons.notifications, color: Colors.white,size:32),
//                            onPressed: (){
//                              Navigator.pop(context);
//                            },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                          ),
                          Container(
                            height: 90,
                            width: 500,
                            color: Color(0xFF004c4c),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Icon(Icons.local_shipping, size: 50, color: Colors.white),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF004c4c),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(4.0, 4.0),
                                          blurRadius: 15.0,
                                          // spreadRadius: 1.0
                                        ),
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(-4.0, -4.0),
                                          blurRadius: 15.0,
                                          //spreadRadius: 1.0
                                        ),
                                      ]
                                  ),
                                ),
//                                MaterialButton(
//                                  onPressed: () {},
//                                  color: Colors.blue,
//                                  textColor: Colors.white,
//                                  child: Icon(
//                                    Icons.camera_alt,
//                                    size: 15,
//                                  ),
//                                  padding: EdgeInsets.all(16),
//                                  shape: CircleBorder(),
//                                ),
                                //  SizedBox(width: 5,),
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Icon(Icons.center_focus_strong, size: 50, color: Colors.white),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF004c4c),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(4.0, 4.0),
                                          blurRadius: 15.0,
                                          // spreadRadius: 1.0
                                        ),
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(-4.0, -4.0),
                                          blurRadius: 15.0,
                                          //spreadRadius: 1.0
                                        ),
                                      ]
                                  ),
                                ),

                                // SizedBox(width: 5,),
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Icon(Icons.equalizer, size: 50, color: Colors.white),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF004c4c),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(4.0, 4.0),
                                          blurRadius: 15.0,
                                          // spreadRadius: 1.0
                                        ),
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(-4.0, -4.0),
                                          blurRadius: 15.0,
                                          //spreadRadius: 1.0
                                        ),
                                      ]
                                  ),
                                ),
                                // SizedBox(width: 10,),
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: Icon(Icons.new_releases, size: 50, color: Colors.white),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF004c4c),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(4.0, 4.0),
                                          blurRadius: 15.0,
                                          // spreadRadius: 1.0
                                        ),
                                        BoxShadow(
                                          color: Colors.teal[800],
                                          offset: Offset(-4.0, -4.0),
                                          blurRadius: 15.0,
                                          //spreadRadius: 1.0
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
//                    child: Row(
//                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.dehaze, color: Colors.white,size:32),
//
////                            onPressed: (){
////                              Navigator.pop(context);
////                            },
//                        ),
//                        Spacer(),
//                        Icon(Icons.notifications, color: Colors.white,size: 32),
////                              Padding(
////                                padding: EdgeInsets.all(25),
////                              ),
//                      ],
//                    ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Production",style: TextStyle(
                            color: Color(0xFF004c4c),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                              ]
                          ),
                          child: ListTile(
                            //contentPadding: EdgeInsetsGeometry.sp
                            contentPadding: EdgeInsets.only(left: 45, top: 5, right: 45),
                            title:Text("Produced", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004c4c),
                            ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right:40),
                              height:40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF004c4c),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 15.0,
                                      // spreadRadius: 1.0
                                    ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                                  ]
                              ),
                              child: Text("3500", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                        ),
                        Container(

                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                              ]
                          ),
                          child: ListTile(
                            //contentPadding: EdgeInsetsGeometry.sp
                            contentPadding: EdgeInsets.only(left: 45, top: 5, right: 45),
                            title:Text("Production", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004c4c),
                            ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right:40),
                              height:40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF004c4c),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 15.0,
                                      // spreadRadius: 1.0
                                    ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                                  ]
                              ),
                              child: Text("3500", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                            ),

                          ),

                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                              ]
                          ),
                          child: ListTile(
                            //contentPadding: EdgeInsetsGeometry.sp
                            contentPadding: EdgeInsets.only(left: 45, top: 5, right: 45),
                            title:Text("Schedule", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004c4c),
                            ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              // padding: EdgeInsets.only(right:40),
                              height:40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF004c4c),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 15.0,
                                      // spreadRadius: 1.0
                                    ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                                  ]
                              ),
                              child: Text("3500", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                        ),
                        Container(
                          height: 70,
                          width: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4.0, 4.0),
                                  blurRadius: 15.0,
                                  // spreadRadius: 1.0
                                ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                              ]
                          ),
                          child: ListTile(
                            //contentPadding: EdgeInsetsGeometry.sp
                            contentPadding: EdgeInsets.only(left: 45, top: 5, right: 45),
                            title:Text("Pending", style: TextStyle(
                              //fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF004c4c),
                            ),
                            ),
                            trailing: Container(
                              alignment: Alignment.center,
                              //padding: EdgeInsets.only(right:40),
                              height:40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF004c4c),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 15.0,
                                      // spreadRadius: 1.0
                                    ),
//                              BoxShadow(
//                                color: Colors.black26,
//                                offset: Offset(-4.0, -4.0),
//                                blurRadius: 15.0,
//                                //spreadRadius: 1.0
//                              ),
                                  ]
                              ),
                              child: Text("3500", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                            ),
                          ),
                        ),

//                      Container(
//                        child: ClayContainer(
//                          color: Colors.grey,
//                          //color: baseColor,
//                          height: 200,
//                          width: 200,
//
//                        ),
//                      )

                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}

