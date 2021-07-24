import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school/Teacher/history.dart';
import 'package:smart_school/Teacher/home.dart';
import 'package:smart_school/Teacher/mark_attendance.dart';
import 'package:smart_school/Teacher/myclasses.dart';
import 'package:smart_school/Teacher/mystudents.dart';
import 'package:smart_school/Teacher/profile.dart';
import 'package:smart_school/Teacher/schedule_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
var data;

class Tdrawer extends StatelessWidget {

  Future<void> _showMyDialog(BuildContext context) async {


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(color: Colors.blue,fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text(
                  'Are you sure to logout ?',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20),


                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.montserrat(color: Colors.blue),


              ),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userPreference');
                await Future.delayed(Duration(seconds: 0));

                Navigator.of(context)
                    .popUntil(ModalRoute.withName(Navigator.defaultRouteName));

                Navigator.of(context).pushAndRemoveUntil(
                  // the new route
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),

                  // this function should return true when we're done removing routes
                  // but because we want to remove all other screens, we make it
                  // always return false
                      (Route route) => false,
                );
                Fluttertoast.showToast(
                    msg: "You are logged out" ,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.montserrat(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String Teacherid = Data['data'][0]['id'];
  String Teachername = Data['data'][0]['name'];

  Future login_history(BuildContext context) async {

    print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/gethistory.php?client_id=${Teacherid}&action=gethistory&tb=client_log";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"gethistory.php"),body:{
      "client_id" : Teacherid ,
      "tb" : "client_log",
      "action" : "gethistory"


    });
    //print('addUser Response: ${response.body}');

    data = json.decode(response.body);

    print(data[0]);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => History()),
    );


  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 250,
            child: UserAccountsDrawerHeader(accountName: Text(
              Teachername,
              style: GoogleFonts.montserrat(color: Colors.white,fontSize: 18,),
            ),
              accountEmail: Text(
                Teacherid,
                style: GoogleFonts.montserrat(color: Colors.black54,fontSize: 14,),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Text(
                  Teachername[0],
                  style: GoogleFonts.montserrat(fontSize: 40),
                ),
              ),  ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Home",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.picture_in_picture,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Notice board",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                  },
                ),
                Divider(),


                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.class__outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Join class",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Myclass()),
                    );

                  },
                ),
                Divider(),


                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Schedule class",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleClass()),
                    );

                  },
                ),
                Divider(),


                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.mark_chat_read,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Mark attendance",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MarkA()),
                    );

                  },
                ),
                Divider(),


                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Profile info",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),

                Divider(),

                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.history,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text(
                      "Login History",
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                    onTap: () {

                      login_history(context);


                    }
                ),

                Divider(),

                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.help,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text(
                      "Help & support",
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Help()),
                      );

                    }
                ),

                Divider(),

                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                    onTap: () async{

                      _showMyDialog(context);

                    }
                ),
                Divider(),

                SizedBox(
                    height: 35,
                    child: Text(
                      '                                        Version- 1.0.0',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 13,),

                    )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
