
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/api/firebase_api.dart';
import 'package:smart_school/help.dart';
import 'package:path/path.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



var Url;



class Applyleave extends StatefulWidget {
  @override
  _ApplyleaveState createState() => _ApplyleaveState();
}

class _ApplyleaveState extends State<Applyleave> {


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
                  Icons.note_add,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     New leave',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
              Tab(icon: Icon(
                  Icons.history,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     previous leave',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
            ],
          ),
          title: Text(
            'Apply leave',
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
            Newleave(),
            Previousleave(),
            //Icon(Icons.directions_bike),
          ],
        ),

      ),
    );
  }
  
}

var Tapplications;

class Newleave extends StatefulWidget {
  @override
  _NewleaveState createState() => _NewleaveState();
}

class _NewleaveState extends State<Newleave> {

  UploadTask? task;
  File? file;
  TextEditingController type = TextEditingController();
  String Teacherid = Data['data'][0]['id'];

  Future applyleave() async{

    //var url = "http://192.168.0.106:80/smartschool_restapi/applyleave.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"applyleave.php"),body:{
      "teacher_id" : Teacherid ,
      "doc_url" : Url,
      "apptype" : type.text,
      "filename" : filename,
      "tb" : "teacher_leave_application",
      "action" : "applyleave"


    });
    //print('addUser Response: ${response.body}');

    var leave = json.decode(response.body);

    print(leave);

  }
  Future leave_history() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getleave.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getleave.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_leave_application",
      "action" : "getleave"


    });
    //print('addUser Response: ${response.body}');

    Tapplications = json.decode(response.body);

   // print(Tapplications);

  }

  @override
  void initState() {
    leave_history();
    super.initState();
  }
  final List<String> app_type = ['leave', 'other'];
  var filename;

  @override
  Widget build(BuildContext context) {

    final fileName = file != null ? basename(file!.path) : 'No file selected';
    filename = fileName;

    return Center(
      child: ListView(
        children:<Widget> [

          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 62),
            child: Column(
              children:<Widget> [
                SizedBox(
                    height: 30,
                  child: Text(
                    'Select application type',
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),
                  ),
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
                      child: DropdownButtonFormField(

                        //initialValue: "202100123",
                       // controller: type,

                      decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'your application type',

                      icon: Icon(
                      Icons.pending_actions_sharp,
                      color: Colors.blue,
                      ),
                      ),

                        items:
                        app_type.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text('$type'),
                          );
                        }).toList(),

                          onChanged: (String? val) {
                            setState(() =>
                            type.text = val!);
                          }),

                      ),


                SizedBox(height: 60,),
                FlatButton.icon(
                    onPressed: () => selectFile(),
                    icon: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.blue,
                    ),
                    label: Text(
                      'Select a file',
                      style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 19,),

                    )
                ),

                SizedBox(height: 8,),
                Text(
                  fileName,
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 16,),
                ),

                SizedBox(height: 40,),
                InkWell(
                  onTap: () => _showMyDialog(context),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.2,
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
                        'Submit leave',
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 14,),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
             ],
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Submit your leave application',
            style: GoogleFonts.montserrat(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text(
                    'Are you sure to upload this file? \n ',
                  style: GoogleFonts.montserrat(color: Colors.black),

                ),
                Text(
                  filename,
                  style: GoogleFonts.montserrat(color: Colors.black,fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                uploadFile();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


Future selectFile() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result == null) return;
    final path =result.files.single.path!;
    setState(()=> file = File(path));
}

  Future uploadFile() async{


    if(file == null) return;

    final fileName = basename(file!.path);
    final destination = 'leave/$fileName';

   task = FirebaseApi.uploadFile(destination,file!);

    Fluttertoast.showToast(
        msg: "Submitted succesfully." ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );

   final snapshot = await task!.whenComplete(() {});
   final urlDownload = await snapshot.ref.getDownloadURL();

   // dynamic currentTime = DateFormat.jm().format(DateTime.now());

       Url = urlDownload;

     //return Previousleave();

    applyleave();


  }



}



class Previousleave extends StatefulWidget {
  @override
  _PreviousleaveState createState() => _PreviousleaveState();
}

class _PreviousleaveState extends State<Previousleave> {
  String Teacherid = Data['data'][0]['id'];


  Future leave_history() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getleave.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getleave.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_leave_application",
      "action" : "getleave"


    });
    //print('addUser Response: ${response.body}');

    Tapplications = json.decode(response.body);

     print(Tapplications);

  }

  @override
  void initState() {
    leave_history();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Tapplications == null ? Container(
        child: Center(
          child: Text(
            "Fetching data....Comeback",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) :
      Tapplications['status'] != 200 ? Container(
        child: Center(
          child: Text(
            "No leave taken",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) : ListView.builder(
          itemCount: Tapplications['data'].length,
          itemBuilder: (BuildContext context,int index){

            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(

                  /*trailing: Text(Adata[index]['device'],
                    style: TextStyle(
                        color: Colors.green,fontSize: 15),),*/
                  title:Text(
                      '\nUploaded file - ${Tapplications['data'][index]['filename']}\n\nApplication type - ${Tapplications['data'][index]['application_type']}\n',
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),
                  ),
                subtitle: Text(
                    'Applied time - ${Tapplications['data'][index]['created_time']}\n\nApplication status - ${Tapplications['data'][index]['application_status']}',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),

                ),
                trailing: Icon(
                    Icons.pending_actions,
                  size: 24,
                  color: Colors.blue,
                ),
              ),
            );
          }
      ),

    );
  }
}


