import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_school/wrapper.dart';


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          );
        }
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children:<Widget> [
            Spacer(),
            Icon(
              Icons.school,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.785,
            ),
            SizedBox(height: 130,),
             Text(
              "Fly  Learn",
              style: GoogleFonts.montserrat(color: Colors.white,fontSize: 32,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 130,)
          ],
        ),


      ),
    );
  }
}


