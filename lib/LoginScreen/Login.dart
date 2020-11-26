import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:salesmanagement/Network_Operations.dart';
import 'package:salesmanagement/Utils.dart';
import 'package:salesmanagement/new_dashboard.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username,password;
  @override
  void initState() {
    username=TextEditingController();
    password=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        padding: EdgeInsets.only(top: 55, bottom: 20),
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
                Image.asset('assets/img/login.png',width: 230,height: 230,),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                      style: TextStyle(color: Colors.white),
                    controller: username,
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
                      obscureText: true,
                      controller: password,
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
                      if(username.text!=null&&password.text!=null&&password.text.length>3){
                        Network_Operations.login(context, username.text, password.text).then((isLogin){
                          if(isLogin=="true"){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>newdashboard("LC0001")), (route) => false);
                          }else{
                            Utils.showError(context,"Invalid Username OR Password");
                          }
                        });
                      }else{
                        Utils.showError(context,"Provide Required Information");
                      }
                    },
                    color: Colors.white,
                    child: Text("SIGN IN",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.teal
                    ),),
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
