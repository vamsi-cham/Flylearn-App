import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_school/Student/Sapply_leave.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/Student/Sjoin.dart';
import 'package:smart_school/Student/feepayment.dart';
import 'package:smart_school/Student/myattendance.dart';
import 'package:smart_school/Student/mysubjects.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:smart_school/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SHome extends StatefulWidget {

  Future<InitializationStatus> _initGoogleMobileAds() {

    return MobileAds.instance.initialize();
  }

  @override
  _SHomeState createState() => _SHomeState();
}

class _SHomeState extends State<SHome> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(



      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: const Color(0xFF00897b)),
        title: Text(
          'Fly Learn',
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


      body:  SHomeBody(),



    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1603354350317-6f7aaa5911c5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1610484826967-09c5720778c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1609751351848-1da0b4379d68?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80',
  'https://images.unsplash.com/photo-1586523903177-854b166f4514?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
  'https://images.unsplash.com/photo-1608600712992-03e5325d94c8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',

];

final List<String> imgdes = [

  'FLy Learn - Study online',
  'Join daily classes',
  'Fly Learn - Teach online',
  'Schedule classes',
  'Conduct daily classes',


];

class SHomeBody extends StatefulWidget {
  @override
  _SHomeBodyState createState() => _SHomeBodyState();
}

class _SHomeBodyState extends State<SHomeBody> {

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
            height: 210,
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
                      color: Color(0xFF00897b),
                    ),
                    title: Text(
                      '\n\Join class',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                      ' Join your todays class from the schedule\n\n',
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
                              MaterialPageRoute(builder: (context) => SJoin()),
                            );
                          },
                          icon: Icon(
                            Icons.transit_enterexit_outlined,
                            size: 19,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'Join         ',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 16,),

                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Spacer(),


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
            height: 250,
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
                      Icons.my_library_books,
                      size: 100,
                      color: Color(0xFF00897b),
                    ),
                    title: Text(
                      '\nSubjects',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                      ' My subjects \n\n',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[

                      FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Mysubjects()),
                            );
                          },
                          icon: Icon(
                            Icons.school,
                            size: 19,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'My subjects',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 15,),

                          )
                      ),

                      FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Myattendance()),
                            );
                          },
                          icon: Icon(
                            Icons.mark_chat_read_outlined,
                            size: 19,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'My attendance',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 15,),

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
            height: 250,
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
                      color: Color(0xFF00897b),
                    ),
                    title: Text(
                      '\nSchool',
                      style: GoogleFonts.montserrat(color: Colors.black,fontSize: 28,),

                    ),
                    subtitle: Text(
                      ' Fee payment\n Apply leave \n\n',
                      style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 13,),

                    ),
                  ),
                  ButtonBar(
                    children: <Widget>[

                      FlatButton.icon(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FeePay()),
                            );

                          },
                          icon: Icon(
                            Icons.payment,
                            size: 19,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'Fee payments',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 15,),

                          )
                      ),

                      FlatButton.icon(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SApplyleave()),
                            );

                          },
                          icon: Icon(
                            Icons.book,
                            size: 19,
                            color: Color(0xFF00897b),
                          ),
                          label: Text(
                            'Apply leave',
                            style: GoogleFonts.montserrat(color: Color(0xFF00897b),fontSize: 15,),

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
                      color: Color(0xFF00897b),
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
                      color: Color(0xFF00897b),
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
}
