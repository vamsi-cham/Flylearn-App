import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/Teacher/home.dart';

import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:smart_school/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class ScheduleClass extends StatefulWidget {

  @override
  _ScheduleClassState createState() => _ScheduleClassState();
}

class _ScheduleClassState extends State<ScheduleClass> {

  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate = DateTime.now();
  late DateTime toDate = DateTime.now().add(Duration(hours: 2));
  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final classController = TextEditingController();
  final secController = TextEditingController();

  String Teacherid = Data['data'][0]['id'];
  String class_status = "not started";


  Future scheduleclass() async{
    DateFormat dateFormat = DateFormat("yyyy-MM-dd kk:mm");

    DateTime formatedDate = fromDate.add(Duration(hours:0, minutes:55, seconds:0));
    DateTime now = DateTime.now();
    /*if(now.isAfter(fromDate) && now.isBefore(formatedDate)){

      class_status = "Online";

    }else if(now.isAfter(formatedDate)){
      class_status = "Expired";
    }*/
    String from = dateFormat.format(fromDate);
    String to = dateFormat.format(formatedDate);
    //String now = dateFormat.format(DateTime.now());


    print(classController.text);
    print(subjectController.text);
    print(secController.text);
    print(from);
    print(to);
    print(Teacherid);


   // var url = "http://192.168.0.106:80/smartschool_restapi/liveclass.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"liveclass.php"),body:{
      "teacher_id" : Teacherid ,
      "class" : classController.text,

      "section" : secController.text,
      "subject" : subjectController.text,

      "fromdate" : from,
      "todate" : to,
      "class_status" : class_status,
      "title" : titleController.text,
      "action" : "scheduleClass",
      "tb" : "live_class",



    });
    //print('addUser Response: ${response.body}');

    var leave = json.decode(response.body);

    print(leave);

  }


  @override
  Widget build(BuildContext context) {

    String Teacherid = Data['data'][0]['id'];
    String Teachername = Data['data'][0]['name'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Schedule class',
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 20,),
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              buildTitle(),
              SizedBox(height: 20),
              yourId(),
              SizedBox(height: 20),
              yourclass(),
              SizedBox(height: 20),
              yoursec(),
              SizedBox(height: 60),
              SizedBox(
                  height: 40,
                child: Text(
                  'Pick Date & Time',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),

                ),
              ),
              buildDateTimePickers(),
              SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () => _showMyDialog(context),
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
                      'Schedule'.toUpperCase(),
                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 14,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  Future<void> _showMyDialog(BuildContext context) async {

    DateFormat dateFormat = DateFormat("yyyy-MM-dd kk:mm");

    DateTime formatedDate = fromDate.add(Duration(hours:0, minutes:55, seconds:0));
    String from = dateFormat.format(fromDate);
    String to = dateFormat.format(formatedDate);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Schedule a new class',
            style: GoogleFonts.montserrat(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //Text('This is a demo alert dialog.'),
                Text(
                  'Are you sure to schedule your class for below timings? \n ',
                  style: GoogleFonts.montserrat(color: Colors.black),

                ),
                Text(
                  '${from}\n\n                  to \n\n${to}',
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
                scheduleclass();
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "Your class is scheduled succesfully." ,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 7,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
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

  Widget buildTitle() =>
      Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 70,
        padding:
        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5)
            ]),
        child: TextFormField(


          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: 'Add title',

            icon: Icon(
              Icons.title,
              color: Colors.blue,
            ),


          ),
          validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
          controller: titleController,

        ),
      );

  Widget yourId() =>
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


          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: 'your subject',

            icon: Icon(
              Icons.book,
              color: Colors.blue,
            ),


          ),

          validator: (id) =>
          id != null && id.isEmpty ? 'subject cannot be empty' : null,
          controller: subjectController,

        ),
      );

  Widget yourclass() =>
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


          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: 'your class',

            icon: Icon(
              Icons.people_alt_rounded,
              color: Colors.blue,
            ),


          ),
          validator: (title) =>
          title != null && title.isEmpty ? 'Class cannot be empty' : null,
          controller: classController,

        ),
      );


  Widget yoursec() =>
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

          decoration: InputDecoration(
            border: InputBorder.none,

            hintText: 'your section',

            icon: Icon(
              Icons.people_alt_rounded,
              color: Colors.blue,
            ),


          ),

          validator: (title) =>
          title != null && title.isEmpty ? 'section cannot be empty' : null,
          controller: secController,

        ),
      );


  Widget buildDateTimePickers() =>
      Column(
        children: [
          buildFrom(),
        ],
      );

  Widget buildFrom() =>

      Row(

        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
            ),
          ),

          Expanded(
            child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(pickDate: false),
            ),
          ),

        ],

      );

  Future pickFromDateTime({required bool pickDate})async{
    final date = await pickDateTime(
        fromDate ,
        pickDate: pickDate,
      //firstDate: pickDate ? fromDate :
    );
    if(date == null) return;

    setState(() => fromDate = date);
  }

  Future<DateTime?> pickDateTime(
      DateTime initialDate,{
        required bool pickDate,
        DateTime? firstDate,
}) async{
    if(pickDate){
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015,8),
          lastDate: DateTime(2101),
      );
      if(date == null) return null;

      final time = Duration(hours: initialDate.hour , minutes: initialDate.minute);

      return date.add(time);
    }
    else{
      final timeofDay = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if(timeofDay == null) return null;

      final date = DateTime(initialDate.year,initialDate.month,initialDate.day);
      final time = Duration(hours: timeofDay.hour,minutes: timeofDay.minute);

      return date.add(time);
    }
  }

  Widget buildDropdownField({

    required String text,
    required VoidCallback onClicked,
  })  =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );



}