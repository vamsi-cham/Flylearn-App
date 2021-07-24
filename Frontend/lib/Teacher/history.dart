import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/home.dart';
import 'package:smart_school/Teacher/myclasses.dart';
import 'package:smart_school/Teacher/profile.dart';
import 'package:smart_school/Teacher/schedule_class.dart';
import 'package:smart_school/Teacher/mystudents.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'Tdrawer.dart';

class History extends StatefulWidget {
  //final Data data


  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String Teacherid = Data['data'][0]['id'];
  String Teachername = Data['data'][0]['name'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login History',
          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onPressed: () {
              //print(data);
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

      body: data == null ? Container() : ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context,int index){
            return ListTile(
                leading: Icon(Icons.devices),
                trailing: Text(data[index]['device'],
                  style: TextStyle(
                      color: Colors.green,fontSize: 15),),
                title:Text(data[index]['datetime'])
            );
          }
      ),

    );
  }
}
