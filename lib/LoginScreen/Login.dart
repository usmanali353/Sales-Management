import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salesmanagement/new_dashboard.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset('assets/img/login.png',width: 200,height: 200,),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      style: TextStyle(color: Colors.white),

                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.white,),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      focusedBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      disabledBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      errorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedErrorBorder: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.white70),
                        hintText: "Username",
                  )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color:Colors.white),
                        prefixIcon: Icon(Icons.lock,color: Colors.white,),
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white, width: 10),
                        ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          disabledBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          errorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                          focusedErrorBorder: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white, width: 2),
                          ),
                        filled: false,
                        hintStyle: new TextStyle(color: Colors.white70),
                        hintText: "Password",
                          fillColor: Colors.white70
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MaterialButton(
                     padding: EdgeInsets.all(16),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>newdashboard()));
                    },
                    color: Colors.white,
                    child: Text("Sign In",),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )
              ],
            )
          ],
        ) /* add child content here */,
      ),
    );
  }
}
