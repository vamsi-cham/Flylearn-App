import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/Teacher/home.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smart_school/admin_login.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

var Data;
var Acaddata;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  String radioButtonItem = 'teacher';

  int id = 1;

  String usertoken = '';
  String client_id = '' ;


  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future getacaddata( id) async{
    //var url = "http://192.168.0.106/smartschool_restapi/history.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"Sacad.php"),body:{
      "student_id" :id,
      "action" : "Sacad",
      "tb":"student_academics_record",

    });

    Acaddata = json.decode(response.body);

    print(Acaddata);


  }


  Future pushClientLog( id, ip, device) async{
    //var url = "http://192.168.0.106/smartschool_restapi/history.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"history.php"),body:{
      "client_id" :id,
      "ipaddress" :ip,
      "device" :device,
      "action" : "history",
      "tb":"client_log",

    });

    if(response.statusCode==200){
     print("client log saved successfully");
    }

  }

  Future login() async {
   // param like this https://localhost/smartschool_restapi/login.php?email=$user.text&password=123456&action=authenticate&tb=student
    //var url = "http://192.168.0.106:80/smartschool_restapi/login.php?email=${user.text}&password=${pass.text}&action=authenticate&tb=$radioButtonItem";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"login.php?email=${user.text}&password=${pass.text}&action=authenticate&tb=$radioButtonItem"),body:{
      "email" : user.text,
      "password" : pass.text,
      "tb" : radioButtonItem,
      "action" : "authenticate"

    });
    //print('addUser Response: ${response.body}');


    Data = json.decode(response.body);
    //print(Data);
    if(Data['status']==201){

    Fluttertoast.showToast(
    msg: "Invalid email or password" ,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0
    );

    print('invalid');

    return;
    }

    usertoken= Data['data'][0]['token'] ;

    client_id = Data['data'][0]['id'] ;

    String? ip = await WifiInfo().getWifiIP();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    print(Data['status']);

    print('Running on ${androidInfo.model}');

    if(Data['status']==200 && radioButtonItem == "teacher"){

      pushClientLog(client_id,ip,androidInfo.model);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()
        ),
      );

      Fluttertoast.showToast(
          msg: "You are logged in successfully" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );


      print('success');
    }else if(Data['status']==200 && radioButtonItem == "student"){

      usertoken= Data['data'][0]['token'] ;

      client_id = Data['data'][0]['id'] ;

      String? ip = await WifiInfo().getWifiIP();

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;


      getacaddata(client_id);
      pushClientLog(client_id,ip,androidInfo.model);



      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SHome()),
      );


      Fluttertoast.showToast(
          msg: "You are logged in successfully" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Color(0xFF00897b),
          textColor: Colors.white,
          fontSize: 16.0
      );




      print('success');

    }

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,

    ));

    return Scaffold(

      body: SafeArea(
        left: true,
        top: true,
        right: true,
        bottom: true,
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue, Colors.blue],
                    ),
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.school,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32, right: 32),
                        child: Text(
                          'Login  to  Fly  learn'.toUpperCase(),
                          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Form(

                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(

                          controller: user,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            hintText: 'username',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 45,
                        margin: EdgeInsets.only(top: 32),
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextFormField(

                          controller: pass,

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.blue,
                            ),
                            hintText: 'password',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'teacher';
                                id = 1;
                              });
                            },
                          ),
                          Text(
                            'Teacher',
                            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              setState(() {
                                radioButtonItem = 'student';
                                id = 2;
                              });
                            },
                          ),
                          Text(
                            'Student',
                            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          if (radioButtonItem == 'teacher') {
                            login();


                          } else {

                            login();

                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.9,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.blue,
                                ],
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'Login',
                              style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {



                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, right: 32),
                            child: Text(
                              'Forgot Password ?',
                              style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 15,),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Login as Admin ?    ",
                              style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),
                            ),
                            Text(
                              "Login ",
                              style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 18,),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Adminlogin()));
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
