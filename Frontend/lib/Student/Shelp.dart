import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/help.dart';

class SHelp extends StatefulWidget {
  @override
  _SHelpState createState() => _SHelpState();
}

class _SHelpState extends State<SHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Help & support',
          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
        ),


        backgroundColor: Color(0xFF00897b),
        elevation: 0.0,

      ),


      drawer: Sdrawer(),

    );
  }
}
