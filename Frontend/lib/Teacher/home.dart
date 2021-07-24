import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smart_school/Teacher/Tdrawer.dart';
import 'package:smart_school/Teacher/apply_leave.dart';
import 'package:smart_school/Teacher/mark_attendance.dart';
import 'package:smart_school/Teacher/myclasses.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:smart_school/Teacher/request_salary.dart';
import 'package:smart_school/Teacher/schedule_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/api/apiurl.dart';
import 'package:smart_school/help.dart';
import 'package:flutter/services.dart';
import 'package:smart_school/ad_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_school/login.dart';


class Home extends StatefulWidget {

  Future<InitializationStatus> _initGoogleMobileAds() {

    return MobileAds.instance.initialize();
  }


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String Teacherid = Data['data'][0]['id'];
  Future myclasses() async {

    // print(Data['data'][0]['id']);


    //var url = "http://192.168.0.106:80/smartschool_restapi/getclasses.php";
    var response = await http.post(Uri.parse(ApiUrl.baseurl+"getclasses.php"),body:{
      "teacher_id" : Teacherid ,
      "class_status" : "Expired",
      "tb" : "live_class",
      "action" : "getclasses"


    });
    //print('addUser Response: ${response.body}');

    Tclasses = json.decode(response.body);

    print(Tclasses);

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
    // print(classes);

    if(Tclasses != null) {
      if (Tclasses['status'] == 200) {
        DateTime present = DateTime.now();
        int i = 0;
        //print(classes.length);
        while (i < Tclasses['data'].length) {
          // cout()
          // print(classes['data']);
          DateTime todate = DateTime.parse(Tclasses['data'][i]['todate']);

          if (present.isAfter(todate)) {
            updateclassstatus(Tclasses['data'][i]['meeting_id'], 'Expired');
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
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: Text(
          'Fly Learn',
          style: GoogleFonts.montserrat(color: Colors.white,fontSize: 20,),
        ),
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.mark_chat_read_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MarkA()),
              );
            },
          ),

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
          ),

        ],
        //centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,

      ),
      extendBodyBehindAppBar: true,

      drawer: Tdrawer(),


      body:  HomeBody(),



    );
  }
}

final List<String> imgList = [

  'https://images.unsplash.com/photo-1609751351848-1da0b4379d68?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80',
  'https://images.unsplash.com/photo-1586523903177-854b166f4514?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1608600712992-03e5325d94c8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1603354350317-6f7aaa5911c5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1610484826967-09c5720778c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',

];

final List<String> imgdes = [

  'Fly Learn - Teach online',
  'Schedule classes',
  'Conduct daily classes',
  'Fly Learn - Study online',
  'Join daily classes',

];

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late BannerAd _ad;


  bool _isAdLoaded = false;
  @override
  void initState() {
    super.initState();

    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );


    _ad.load();
  }

  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '${imgdes[imgList.indexOf(item)]}',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();


  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
                Container(
                child: AdWidget(ad: _ad),
                width: _ad.size.width.toDouble(),
                height: 72.0,
                alignment: Alignment.center,
              ),
          SizedBox(   //Use of SizedBox
            height: 10,
          ),
          Container(
            height: 200,
            //width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   ListTile(
                    leading: Icon(
                        Icons.class__outlined,
                        size: 100,
                      color: Colors.blue,
                    ),
                    title: Text(
                        '\n\Join class',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                        ' Conduct a class from the schedule\n\n',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Myclass()),
                            );
                          },
                          icon: Icon(
                            Icons.transit_enterexit_outlined,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Join         ',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 16,),

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(   //Use of SizedBox
            height: 15,
          ),

          Container(
              child: Column(children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: imageSliders,
                ),
              ],)
          ),

          // Spacer(),
          SizedBox(   //Use of SizedBox
            height: 15,
          ),
          Container(
            height: 200,
            //width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      size: 100,
                      color: Colors.blue,
                    ),
                    title: Text(
                      '\nSchedule class',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                      ' Schedule the upcoming classes\n\n',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[

                   FlatButton.icon(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Myclass()),
                         );
                       },
                       icon: Icon(
                         Icons.history,
                         size: 19,
                         color: Colors.blue,
                       ),
                       label: Text(
                           '   View previous        ',
                         style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                       )
                   ),

                      FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ScheduleClass()),
                            );
                          },
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'New class',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                          )
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(   //Use of SizedBox
            height: 15,
          ),
          Container(
            height: 300,
            //width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.business_sharp,
                      size: 100,
                      color: Colors.blue,
                    ),
                    title: Text(
                      '\nSchool',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                      ' Board meetings,\n Request Salary, Apply leave \n\n',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[

                      FlatButton.icon(
                          onPressed: () {


                          },
                          icon: Icon(
                            Icons.meeting_room_outlined,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Board Meeting',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                          )
                      ),

                      FlatButton.icon(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Requestsalary()),
                            );

                          },
                          icon: Icon(
                            Icons.request_page,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            'Salary request',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                          )
                      ),

                    ],
                  ),

                  ButtonBar(
                    children: <Widget>[

                      FlatButton.icon(
                          onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Applyleave()),
                              );
                          },
                          icon: Icon(
                            Icons.book,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            '     Apply leave',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                          )
                      ),

                      FlatButton.icon(
                          onPressed: () {

                          },
                          icon: Icon(
                            Icons.notification_important,
                            size: 19,
                            color: Colors.blue,
                          ),
                          label: Text(
                            '  School notice',
                            style: GoogleFonts.montserrat(color: Colors.blue,fontSize: 15,),

                          )
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),

          SizedBox(   //Use of SizedBox
            height: 15,
          ),

          Container(
            height: 130,
            //width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // if you need this
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(

                    title: Text(
                      'About us',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20,),

                    ),
                    subtitle: Text(
                      'Check our blog ',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

                    ),
                    leading: Icon(
                      Icons.check_circle,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                          "check",
                        style: GoogleFonts.montserrat(color: Colors.white,fontSize: 13,),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
  @override
  void dispose() {

    _ad.dispose();

    super.dispose();
  }
}
