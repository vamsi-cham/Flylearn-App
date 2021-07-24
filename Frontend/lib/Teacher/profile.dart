import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/Teacher/home.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String Teacherid = Data['data'][0]['id'];
  String Teachername = Data['data'][0]['name'];
  String pass = Data['data'][0]['password'];
  TextEditingController currentpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  Future updatepass() async {

    print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/updatepass.php?user_id=${Teacherid}&password=${newpass.text}&action=updatepassword&tb=teacher";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"updatepass.php"),body:{
      "user_id" : Teacherid ,
      "password" : newpass.text,
      "tb" : "teacher",
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
                MaterialPageRoute(builder: (context) => Help()),
              );
            },
          )
        ],
        //centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,

      ),


      drawer: Tdrawer(),


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
                        color: Colors.blue,
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
                        color: Colors.blue,
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
                        color: Colors.blue,
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
                       MaterialPageRoute(builder: (context) => Home()),
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
                            Colors.blue,
                            Colors.blue,
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
