import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:flutter/services.dart';
import 'Sdrawer.dart';


class Shistory extends StatefulWidget {
  @override
  _ShistoryState createState() => _ShistoryState();
}

class _ShistoryState extends State<Shistory> {
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
