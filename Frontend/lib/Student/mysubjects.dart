import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/Student/Sjoin.dart';
import 'package:smart_school/Student/Sprofile.dart';
import 'package:smart_school/Student/feepayment.dart';
import 'package:smart_school/Student/myattendance.dart';

import 'package:smart_school/login.dart';
import 'package:flutter/services.dart';

class Mysubjects extends StatefulWidget {
  @override
  _MysubjectsState createState() => _MysubjectsState();
}

class _MysubjectsState extends State<Mysubjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: const Color(0xFF00897b)),
        title: Text(
          'My subjects',
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


    );
  }
}
