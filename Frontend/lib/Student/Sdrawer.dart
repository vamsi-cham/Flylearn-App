import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/Student/Shistory.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/Student/Sjoin.dart';
import 'package:smart_school/Student/Sprofile.dart';
import 'package:smart_school/Student/feepayment.dart';
import 'package:smart_school/Student/myattendance.dart';
import 'package:smart_school/Student/mysubjects.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/api/apiurl.dart';

import 'package:smart_school/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var data;

class Sdrawer extends StatefulWidget {
  @override
  _SdrawerState createState() => _SdrawerState();
}

class _SdrawerState extends State<Sdrawer> {


  Future<void> _showMyDialog(BuildContext context) async {


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontWeight: FontWeight.bold),
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
                style: GoogleFonts.montserrat(color: Color(0xFF00897b)),


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
                    backgroundColor: Color(0xFF00897b),
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
            TextButton(
              child: Text(
                  'No',
                style: GoogleFonts.montserrat(color: Color(0xFF00897b)),
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


  String Studentid = Data['data'][0]['id'];
  String Studentname = Data['data'][0]['name'];
  String Sclass = Acaddata[0]['class'];
  String Section = Acaddata[0]['section'];

  Future login_history(BuildContext context) async {

    print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/gethistory.php?client_id=${Teacherid}&action=gethistory&tb=client_log";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"gethistory.php"),body:{
      "client_id" : Studentid ,
      "tb" : "client_log",
      "action" : "gethistory"


    });
    //print('addUser Response: ${response.body}');

    data = json.decode(response.body);

    //print(data);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Shistory()),
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
            //color: Colors.greenAccent,
            height: 250,
            child: UserAccountsDrawerHeader(

              accountName: Text(
                Studentname,
                style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
              ),
              accountEmail: Text(
                'Class & section - ${Sclass} ${Section}',
                style: GoogleFonts.montserrat(color: Colors.white,fontSize: 14,),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF00897b),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  Studentname[0],
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
                    backgroundColor: const Color(0xFF00897b),
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
                      MaterialPageRoute(builder: (context) => SHome()),
                    );
                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00897b),
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
                    backgroundColor: const Color(0xFF00897b),
                    child: Icon(
                      Icons.video_label,
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
                      MaterialPageRoute(builder: (context) => SJoin()),
                    );

                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00897b),
                    child: Icon(
                      Icons.my_library_books,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "My subjects",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mysubjects()),
                    );

                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00897b),
                    child: Icon(
                      Icons.sticky_note_2_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "My attendance",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Myattendance()),
                    );

                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00897b),
                    child: Icon(
                      Icons.business_sharp,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  title: Text(
                    "Fee payment",
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),

                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeePay()),
                    );

                  },
                ),
                Divider(),

                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF00897b),
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
                      MaterialPageRoute(builder: (context) => Sprofile()),
                    );
                  },
                ),

                Divider(),

                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF00897b),
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
                      backgroundColor: const Color(0xFF00897b),
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
                        MaterialPageRoute(builder: (context) => SHelp()),
                      );

                    }
                ),

                Divider(),

                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF00897b),
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
