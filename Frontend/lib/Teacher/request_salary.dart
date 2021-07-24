
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var month;


class Requestsalary extends StatefulWidget {
  @override
  _RequestsalaryState createState() => _RequestsalaryState();
}

class _RequestsalaryState extends State<Requestsalary> {
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
                    '     Request',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
              Tab(icon: Icon(
                Icons.history,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     Request status',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
            ],
          ),
          title: Text(
            'Salary',
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
            Newreq(),
            Previousreq(),
            //Icon(Icons.directions_bike),
          ],
        ),

      ),
    );
  }

}
var salary;

class Newreq extends StatefulWidget {
  @override
  _NewreqState createState() => _NewreqState();
}

class _NewreqState extends State<Newreq> {

  String Teacherid = Data['data'][0]['id'];
  Future getsalary() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getsalary.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getsalary.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_salary_request",
      "action" : "getsalary"


    });
    //print('addUser Response: ${response.body}');

    salary = json.decode(response.body);

    //print(salary);

  }

  @override
  void initState() {
    getsalary();
    super.initState();
  }


  Future reqsalary() async{

    //var url = "http://192.168.0.106:80/smartschool_restapi/reqsalary.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"reqsalary.php"),body:{
      "teacher_id" : Teacherid ,
      "month" : type.text,
      "tb" : "teacher_salary_request",
      "action" : "reqsalary"


    });
    //print('addUser Response: ${response.body}');

    var leave = json.decode(response.body);

    print(leave);

  }


  final List<String> months = ['January','Feburay','March','April','May','June','July','August','September','October','November','December'];
  TextEditingController type = TextEditingController();

  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {

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
                    'choose a month for salary request\n',
                    style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50,
                  padding:
                  EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5)
                      ]),
                  child: DropdownButtonFormField(

                   // initialValue: "202100123",

                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: 'choose a month',

                      icon: Icon(
                        Icons.calendar_today_sharp,
                        color: Colors.blue,
                      ),

                    ),
                      items:
                      months.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text('$type'),
                        );
                      }).toList(),

                      onChanged: (String? val) {
                        setState(() =>
                        type.text = val!);
                      }

                  ),
                ),


                SizedBox(height: 40,),
                InkWell(
                  onTap: () => uploadFile(),
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.5,
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
                        'Request salary',
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


  Future uploadFile() async{


    reqsalary();


    Fluttertoast.showToast(
        msg: "Requested succesfully." ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }



}






class Previousreq extends StatefulWidget {
  @override
  _PreviousreqState createState() => _PreviousreqState();
}

class _PreviousreqState extends State<Previousreq> {
  String Teacherid = Data['data'][0]['id'];


  Future getsalary() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getsalary.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getsalary.php"),body:{
      "teacher_id" : Teacherid ,
      "tb" : "teacher_salary_request",
      "action" : "getsalary"


    });
    //print('addUser Response: ${response.body}');

    salary = json.decode(response.body);

    //print(salary);

  }

  @override
  void initState() {
    getsalary();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: salary == null ? Container(
        child: Center(
          child: Text(
            "Fetching data....Comeback",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      ) :
      salary['status'] != 200 ? Container(
        child: Center(
          child: Text(
            "No requests made..",
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
            textAlign: TextAlign.center,
          ),
        ),
      )  : ListView.builder(
          itemCount: salary['data'].length,
          itemBuilder: (BuildContext context,int index){

            return Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(

                /*trailing: Text(Adata[index]['device'],
                    style: TextStyle(
                        color: Colors.green,fontSize: 15),),*/
                title:Text(
                  '\nRequested salary for month : ${salary['data'][index]['month']}\n',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 17,),
                ),
                subtitle: Text(
                  '\nApplied time - ${salary['data'][index]['created_time']}\n\nRequested status - ${salary['data'][index]['req_status']}\n\ncredited status - ${salary['data'][index]['credit_status']}\n',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),

                ),
                trailing: Icon(
                  Icons.credit_card_rounded,
                  size: 29,
                  color: Colors.blue,
                ),
              ),
            );
          }
      ),

    );
  }
}

