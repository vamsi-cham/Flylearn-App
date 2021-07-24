import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/Teacher/meeting.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var sclasses;

class SJoin extends StatefulWidget {
  @override
  _SJoinState createState() => _SJoinState();
}

class _SJoinState extends State<SJoin> {

  var serverUrl = "https://meet.jit.si";

  String Sclass = Acaddata[0]['class'];
  String Section = Acaddata[0]['section'];
  Future myclasses() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getclasses.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"Sgetclasses.php"),body:{
      "Sclass" : Sclass ,
      "Section" : Section,
      "class_status" : "Expired",
      "tb" : "live_class",
      "action" : "Sgetclasses"


    });
    //print('addUser Response: ${response.body}');

    sclasses = json.decode(response.body);

     print(sclasses);

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

    if(sclasses != null) {
      if (sclasses['status'] == 200) {
        DateTime present = DateTime.now();
        int i = 0;
        //print(classes.length);
        while (i < sclasses['data'].length) {
          // cout()
          DateTime todate = DateTime.parse(sclasses['data'][i]['todate']);

          if (present.isAfter(todate)) {
            updateclassstatus(sclasses['data'][i]['meeting_id'], 'Expired');
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
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: const Color(0xFF00897b)),
        title: Text(
          'Join class',
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

      body: sclasses == null ? Container(
        child: Center(
          child: Text(
            "Fetching data....Comeback",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) :
      sclasses['status'] != 200 ? Container(
        child: Center(
          child: Text(
            "No scheduled classes for today",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) : ListView.builder(
          itemCount: sclasses['data'].length,
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
                      '\n${sclasses['data'][index]['title']}\n\nClass timings :\n ${sclasses['data'][index]['fromdate']} - ${sclasses['data'][index]['todate']}\n',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
                    ),
                    subtitle: Text(
                      '\nSubject - ${sclasses['data'][index]['subject']}\n\nClass - ${sclasses['data'][index]['class']}\n\nSection - ${sclasses['data'][index]['section']}\n\n\nClass status - ${sclasses['data'][index]['class_status']}',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),

                    ),
                    trailing: Icon(
                      Icons.calendar_today_rounded,
                      size: 29,
                      color: Color(0xFF00897b),
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

                            if (sclasses['data'][index]['class_status'] == "class started"){

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Meeting(
                                      meetingCode: sclasses['data'][index]['meeting_id'],
                                      meetingTitle: sclasses['data'][index]['title'],
                                      clientName: Data['data'][0]['name'],
                                      clientEmail: Data['data'][0]['email'],
                                      serverUrl: serverUrl,
                                    ))); }
                            else{

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Your teacher didn't start the class",
                                        style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          //style: GoogleFonts.montserrat(color: Colors.white),
                                          child: Text(
                                              'Ok',
                                            style: GoogleFonts.montserrat(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });

                            }

                          },
                          icon: Icon(
                            Icons.video_call,
                            size: 33,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'Join class',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 20,),

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
