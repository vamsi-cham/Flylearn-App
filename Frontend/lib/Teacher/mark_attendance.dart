import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:intl/intl.dart';

var atten;


class MarkA extends StatefulWidget {
  @override
  _MarkAState createState() => _MarkAState();
}

class _MarkAState extends State<MarkA> {

  String Teacherid = Data['data'][0]['id'];
  String Teachername = Data['data'][0]['name'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.amberAccent,
            //indicatorSize: TabBarIndicatorSize.label,

            tabs: [
              Tab(icon: Icon(
                Icons.mark_chat_read,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     Mark attendance',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
              Tab(icon: Icon(
                Icons.location_history,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     Attendance history',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
            ],
          ),
          title: Text(
            'Mark Attendance',
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
          backgroundColor: Colors.blue,
          elevation: 0.0,

        ),


        drawer: Tdrawer(),

        body: TabBarView(
          children: [
            Tmark(),
            Ahistory(),

          ],
        ),

      ),
    );
  }
}
var adata;
class Tmark extends StatefulWidget {
  @override
  _TmarkState createState() => _TmarkState();
}

class _TmarkState extends State<Tmark> {

  String Teacherid = Data['data'][0]['id'];

  Future markattendance() async{


    print(Data['data'][0]['id']);
    String? ip = await WifiInfo().getWifiIP();

    //var url = "http://192.168.0.106:80/smartschool_restapi/markattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"markattendance.php"),body:{
      "teacher_id" : Teacherid ,
      "ipaddress" : ip,
      "tb" : "teacher_attendance",
      "action" : "markattendance"


    });
    //print('addUser Response: ${response.body}');

    atten = json.decode(response.body);

    print(atten);

  }

  Future attendance_history() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getattendance.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_attendance",
      "action" : "getattendance"


    });
    //print('addUser Response: ${response.body}');

    adata = json.decode(response.body);

     print(adata);

  }


  @override
  void initState() {
    attendance_history();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      children:<Widget> [

        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 62),
          child: Column(
            children: [

              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {



                  if(adata['status'] == 201 ){
                    print(adata['data']);
                    markattendance();
                    Fluttertoast.showToast(
                        msg: "Your attendance is marked successfully" ,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 10,
                        backgroundColor: Colors.yellow,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );

                  }else {
                    //()
                    //DateTime know = new DateTime.now();
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    String now = dateFormat.format(DateTime.now());
                    // print(now);
                    //String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    //DateTime date = new DateTime(now.day, now.month, now.year);

                    String last = adata['data'][0]['datetime'];
                    String lastattendance = last.substring(0, 10);


                    //print(lastattendance);

                    if (now == lastattendance) {
                      Fluttertoast.showToast(
                          msg: "You have already marked your attendance today at ${last
                              .substring(
                              10)} \n\n Check your attendance history",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    } else {
                      markattendance();
                      Fluttertoast.showToast(
                          msg: "Your attendance is marked successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 10,
                          backgroundColor: Colors.yellow,
                          textColor: Colors.black,
                          fontSize: 16.0
                      );
                    }

                    // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                    //String lastattendance = dateFormat.format(last);
                    // print(lastattendance);
                    // DateTime lastdate = new DateTime(last.day, last.month, last.year);


                    // print(lastdate);
                    //if


                    // markattendance();
                  }

                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                  child: Center(
                    child: Text(
                      'Mark my attendance',
                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16,),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}



class Ahistory extends StatefulWidget {

  @override
  _AhistoryState createState() => _AhistoryState();
}

class _AhistoryState extends State<Ahistory> {

  Future attendance_history() async {

    // print(Data['data'][0]['id']);

    String Teacherid = Data['data'][0]['id'];
    //var url = "http://192.168.0.106:80/smartschool_restapi/getattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getattendance.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_attendance",
      "action" : "getattendance"


    });
    //print('addUser Response: ${response.body}');

    adata = json.decode(response.body);

    print(adata);

  }


  @override
  void initState() {
    attendance_history();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: adata == null ? Container(
        child: Center(
          child: Text(
            "Fetching data....Comeback",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) :
      adata['status'] != 200 ? Container(
        child: Center(
          child: Text(
            "No attendance marked till now",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) : ListView.builder(
          itemCount: adata['data'].length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                leading: Icon(Icons.devices),
                /*trailing: Text(Adata[index]['device'],
                  style: TextStyle(
                      color: Colors.green,fontSize: 15),),*/
                title:Text(adata['data'][index]['datetime']),
              trailing: Icon(Icons.verified,
                size: 24,
                color: Colors.blue,),
            );
          }
      ),

    );
  }
}
