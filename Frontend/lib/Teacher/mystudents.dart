import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';

class MyStudents extends StatefulWidget {
  @override
  _MyStudentsState createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {

  String Teacherid = Data['data'][0]['id'];
  String Teachername = Data['data'][0]['name'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'My students',
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


    );
  }
}
