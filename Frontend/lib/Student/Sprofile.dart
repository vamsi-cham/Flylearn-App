import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:flutter/services.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Sprofile extends StatefulWidget {
  @override
  _SprofileState createState() => _SprofileState();
}

class _SprofileState extends State<Sprofile> {
  String Studentid = Data['data'][0]['id'];
  String Studentname = Data['data'][0]['name'];
  String pass = Data['data'][0]['password'];
  TextEditingController currentpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  Future updatepass() async {

    print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/updatepass.php?user_id=${Teacherid}&password=${newpass.text}&action=updatepassword&tb=teacher";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"updatepass.php"),body:{
      "user_id" : Studentid ,
      "password" : newpass.text,
      "tb" : "student",
      "action" : "updatepassword"


    });
    //print('addUser Response: ${response.body}');

    var res = json.decode(response.body);

    //print(res);




  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Update profile',
          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SHelp()),
              );
            },
          )
        ],
        //centerTitle: true,
        backgroundColor: Color(0xFF00897b),
        elevation: 0.0,

      ),


      drawer: Sdrawer(),


      body: ListView(
        children: <Widget>[

          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 62),
            child: Column(
              children: <Widget>[
                //Spacer(),

                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(
                    controller: currentpass,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'Current password',
                      icon: Icon(
                        Icons.person_outline,
                        color: Color(0xFF00897b),
                      ),
                    ),


                  ),
                ),
                SizedBox(   //Use of SizedBox
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(
                    controller: newpass,
                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'New password',

                      icon: Icon(
                        Icons.vpn_key_outlined,
                        color: Color(0xFF00897b),
                      ),
                    ),


                  ),
                ),

                SizedBox(   //Use of SizedBox
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 45,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: TextFormField(

                    controller: confirmpass,

                    //obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'Confirm password',


                      icon: Icon(
                        Icons.phone,
                        color: Color(0xFF00897b),
                      ),
                    ),


                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: () async {

                    if(newpass.text == confirmpass.text && currentpass.text == pass){

                      updatepass();
                      Fluttertoast.showToast(
                          msg: "password updated successfully" ,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SHome()),
                      );

                    }else if (newpass.text != confirmpass.text){
                      Fluttertoast.showToast(
                          msg: "new passwords are not matching" ,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    }else if (currentpass.text != pass && pass!=null && currentpass!=null){
                      Fluttertoast.showToast(
                          msg: "incorrect current password" ,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );

                    }else if(newpass.text == null || confirmpass.text==null || pass==null ){
                      Fluttertoast.showToast(
                          msg: "fill your details" ,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    }

                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 3.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00897b),
                            Color(0xFF00897b),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Save'.toUpperCase(),
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16,),
                      ),
                    ),
                  ),
                ),

                // Spacer(flex: 3,),
              ],
            ),
          )


        ],
      ),

    );
  }
}
