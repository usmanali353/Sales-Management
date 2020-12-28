import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:acmc_customer/Network_Operations.dart';
import 'package:acmc_customer/Sales_Services/Deliveries/trackDeliveryList.dart';
import 'package:acmc_customer/Utils.dart';
import 'package:acmc_customer/new_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username,password;
  var selectedPreference;
  @override
  void initState() {
    username=TextEditingController();
    password=TextEditingController();
    Utils.setupQuickActions(context);
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
                        showAlertDialog(context);
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
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget btn = FlatButton(
      child: Text("Set"),
      onPressed: () {
        if(selectedPreference=="Testing"){
          Navigator.pop(context);
          SharedPreferences.getInstance().then((prefs){
            prefs.setString("mode", "Testing");
            Network_Operations.login(context, username.text, password.text).then((isLogin){
              if(isLogin=="true"){
                Network_Operations.getUserInfo(context, username.text, password.text).then((userInfo){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>newdashboard("LC0001")), (route) => false);
                });
              }else{
                Utils.showError(context,"Invalid Username or Password");
              }
            });
          });
        }else if(selectedPreference=="Live"){
          Navigator.pop(context);
          SharedPreferences.getInstance().then((prefs){
            prefs.setString("mode", "Live");
            Network_Operations.login(context, username.text, password.text).then((isLogin){
              if(isLogin=="true"){
                Network_Operations.getUserInfo(context, username.text, password.text).then((userInfo){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>newdashboard("LC0001")), (route) => false);
                });
              }else{
                Utils.showError(context,"Invalid Username or Password");
              }
            });
          });
        }

      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Select Enviroment to Use the App"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile(
                title: Text("Testing"),
                value: 'Testing',
                groupValue: selectedPreference,
                onChanged: (choice) {
                  setState(() {
                    this.selectedPreference = choice;
                  });
                },
              ),
              RadioListTile(
                title: Text("Live"),
                value: 'Live',
                groupValue: selectedPreference,
                onChanged: (choice) {
                  setState(() {
                    this.selectedPreference = choice;
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        btn
      ],
    );

    // show the dialog
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
