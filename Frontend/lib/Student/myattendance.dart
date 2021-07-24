import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/login.dart';
import 'package:flutter/services.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Myattendance extends StatefulWidget {
  @override
  _MyattendanceState createState() => _MyattendanceState();
}

class _MyattendanceState extends State<Myattendance> {
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
          iconTheme: IconThemeData(color: Colors.white),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: const Color(0xFF00897b)),
          title: Text(
            'My attendance',
            style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.help,

              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SHelp()),
                );
              },
            ),
          ],
          //centerTitle: true,
          backgroundColor: const Color(0xFF00897b),
          elevation: 0.0,

        ),
        extendBodyBehindAppBar: true,

        drawer: Sdrawer(),
        body: TabBarView(
          children: [
            Smark(),
            Ahistory(),

          ],
        ),
      ),
    );
  }
}

class Smark extends StatefulWidget {
  @override
  _SmarkState createState() => _SmarkState();
}

class _SmarkState extends State<Smark> {

  String Studentid = Data['data'][0]['id'];

  Future Smarkattendance() async{


    print(Data['data'][0]['id']);
    String? ip = await WifiInfo().getWifiIP();

    //var url = "http://192.168.0.106:80/smartschool_restapi/markattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"Smarkattendance.php"),body:{
      "student_id" : Studentid ,
      "ipaddress" : ip,
      "tb" : "student_attendance",
      "action" : "Smarkattendance"


    });
    //print('addUser Response: ${response.body}');

   var atten = json.decode(response.body);

    print(atten);

  }

  Future Sattendance_history() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"Sgetattendance.php"),body:{
      "student_id" : Studentid ,
      "tb" : "student_attendance",
      "action" : "Sgetattendance"


    });
    //print('addUser Response: ${response.body}');

    var Adata = json.decode(response.body);

    //print(Adata);
    SAdata = Adata['data'];
   // print(SAdata);

  }

  @override
  void initState() {
    Sattendance_history();
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


                  if(SAdata.length == 0  ){
                    //print(SAdata['data']);
                    Smarkattendance();
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

                    String last = SAdata[0]['datetime'];
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
                      Smarkattendance();
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
                          Color(0xFF00897b),
                          Color(0xFF00897b),
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

List SAdata = [];

class Ahistory extends StatefulWidget {

  @override
  _AhistoryState createState() => _AhistoryState();
}

class _AhistoryState extends State<Ahistory> {

  String Studentid = Data['data'][0]['id'];

  Future Sattendance_history() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getattendance.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"Sgetattendance.php"),body:{
      "student_id" : Studentid ,
      "tb" : "student_attendance",
      "action" : "Sgetattendance"


    });
    //print('addUser Response: ${response.body}');

   var Adata = json.decode(response.body);

   print(Adata);
   SAdata = Adata['data'];
   print(SAdata);

  }

  @override
  void initState() {
    Sattendance_history();
    super.initState();
  }

  DataRow _getDataRow(SAdata) {
    var month =  DateFormat.MMMM().format(DateTime.parse(SAdata["datetime"]));
    //print(month);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(SAdata["studentId"])),
        DataCell(Text(month)),
        DataCell(Text(SAdata["datetime"])),
        DataCell(Text(SAdata["ipaddress"])),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SAdata.length == 0 ? Container(
      child: Center(
        child: Text(
          "No attendance marked till now",
          style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
          textAlign: TextAlign.center,
        ),
      ),
    ) :
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget> [
              //Spacer(),
              SizedBox(height: 160,),
              DataTable(
                showBottomBorder: true,
                columns:  <DataColumn>[
                  DataColumn(
                    label: Text(
                        'Your ID',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),

                  ),
                  DataColumn(
                    label: Text(
                      'Month',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                        'Date time',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                        'IP',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),),
                  ),

                ],
                rows: List.generate(
                    SAdata.length, (index) => _getDataRow(SAdata[index])),

              ),
              //Spacer(),
            ],
          ),
        ),
      );
      /*ListView.builder(
          itemCount: SAdata.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
              leading: Icon(Icons.devices),
              /*trailing: Text(Adata[index]['device'],
                  style: TextStyle(
                      color: Colors.green,fontSize: 15),),*/
              title:Text(SAdata[index]['datetime']),
              trailing: Icon(Icons.verified,
                size: 24,
                color: Colors.blue,),
            );
          }
      ),*/


  }
}

