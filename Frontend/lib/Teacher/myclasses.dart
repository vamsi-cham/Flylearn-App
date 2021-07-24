
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/Teacher/meeting.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Myclass extends StatefulWidget {
  @override
  _MyclassState createState() => _MyclassState();
}

var Tclasses;

class _MyclassState extends State<Myclass> {

  var serverUrl = "https://meet.jit.si";


  Future<void> _showMyDialog(BuildContext context,meeting_id) async {


    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'My classes',
            style: GoogleFonts.montserrat(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text(
                  'Are you sure to delete? \n ',
                  style: GoogleFonts.montserrat(color: Colors.black),

                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                print('Confirmed');
                setState(() {
                  deleteclass(meeting_id);
                });

                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Deleted" ,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 7,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },
            ),
            TextButton(
              child: Text('No'),
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

  Future deleteclass(meeting_id) async{

    //var url = "http://192.168.0.106:80/smartschool_restapi/deleteclass.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"deleteclass.php"),body:{
      "meeting_id" : meeting_id ,
      "tb" : "live_class",
      "action" : "deleteclass"


    });
    //print('addUser Response: ${response.body}');

    var leave = json.decode(response.body);

    print(leave);


  }


  Future myclasses() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getclasses.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getclasses.php"),body:{
      "teacher_id" : Teacherid ,
      "class_status" : "Expired",
      "tb" : "live_class",
      "action" : "getclasses"


    });
    //print('addUser Response: ${response.body}');

    Tclasses = json.decode(response.body);

    print(Tclasses);

  }

  Future updateclassstatus(meeting_id ,Cstatus) async{

    var response = await http.post(Uri.parse(ApiUrl.baseurl+"updatestatus.php"),body:{
      "meeting_id" : meeting_id ,
      "class_status" : Cstatus,
      "tb" : "live_class",
      "action" : "updateclassstatus"


    });
    //print('addUser Response: ${response.body}');

    var status = json.decode(response.body);

    print(status);


  }
  @override
  void initState() {
    myclasses();
   // print(classes);

    if(Tclasses != null) {
      if (Tclasses['status'] == 200) {
        DateTime present = DateTime.now();
        int i = 0;
        //print(classes.length);
        while (i < Tclasses['data'].length) {
          // cout()
          // print(classes['data']);
          DateTime todate = DateTime.parse(Tclasses['data'][i]['todate']);

          if (present.isAfter(todate)) {
            updateclassstatus(Tclasses['data'][i]['meeting_id'], 'Expired');
            //deleteclass(classes[i]['meeting_id']);
          }


          i++;
        }
      }
    }

    super.initState();
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My classes',
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


    body: Tclasses == null ? Container(
      child: Center(
        child: Text(
          "Fetching data....Comeback",
          style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
          textAlign: TextAlign.center,
        ),
      ),
    ) :
    Tclasses['status'] != 200 ? Container(
        child: Center(
          child: Text(
            "No scheduled classes",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) : ListView.builder(
          itemCount: Tclasses['data'].length,
          itemBuilder: (BuildContext context,int index){

            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(

                    /*trailing: Text(Adata[index]['device'],
                        style: TextStyle(
                            color: Colors.green,fontSize: 15),),*/
                    title:Text(
                      '\n${Tclasses['data'][index]['title']}\n\nClass timings :\n ${Tclasses['data'][index]['fromdate']} - ${Tclasses['data'][index]['todate']}\n',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
                    ),
                    subtitle: Text(
                      '\nSubject - ${Tclasses['data'][index]['subject']}\n\nClass - ${Tclasses['data'][index]['class']}\n\nSection - ${Tclasses['data'][index]['section']}\n\n\nClass status - ${Tclasses['data'][index]['class_status']}',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),

                    ),
                    trailing: Icon(
                      Icons.calendar_today_rounded,
                      size: 29,
                      color: Colors.blue,
                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      /*FlatButton(
                        child: const Text('BTN1'),
                        onPressed: () {/* ... */},
                      ),*/
                      FlatButton.icon(
                          onPressed: () {

                            _showMyDialog(context,Tclasses['data'][index]['meeting_id']);

                          },
                          icon: Icon(
                            Icons.delete,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Delete',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 16,),

                          )
                      ),
                      FlatButton.icon(
                          onPressed: () {

                            updateclassstatus(Tclasses['data'][index]['meeting_id'] , 'class started');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Meeting(
                                      meetingCode: Tclasses['data'][index]['meeting_id'],
                                      meetingTitle: Tclasses['data'][index]['title'],
                                      clientName: Data['data'][0]['name'],
                                      clientEmail: Data['data'][0]['email'],
                                      serverUrl: serverUrl,
                                    )));

                          },
                          icon: Icon(
                            Icons.video_call,
                            size: 33,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Start class',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 20,),

                          )
                      ),
                    ],
                  ),
                ],
              ),

            );
          }
      ),

    );
  }
}
