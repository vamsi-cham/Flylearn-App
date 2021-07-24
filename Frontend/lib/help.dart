import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Help & support',
          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
        ),

        backgroundColor: Colors.blue,
        elevation: 0.0,

      ),
    );
  }
}
