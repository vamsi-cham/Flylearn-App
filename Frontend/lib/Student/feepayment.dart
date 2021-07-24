import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smart_school/Student/Sdrawer.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/Student/Sjoin.dart';
import 'package:smart_school/help.dart';
import 'package:smart_school/Student/Shelp.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/Student/Sprofile.dart';
import 'package:smart_school/Student/feepayment.dart';
import 'package:smart_school/Student/myattendance.dart';
import 'package:smart_school/Student/mysubjects.dart';
import 'package:smart_school/login.dart';
import 'package:flutter/services.dart';

var time;
var status;
var id;

class FeePay extends StatefulWidget {
  @override
  _FeePayState createState() => _FeePayState();
}

class _FeePayState extends State<FeePay> {




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
                Icons.payment,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     Pay fee',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
              Tab(icon: Icon(
                Icons.history,
                size: 19,
                color: Colors.white,
              ),
                  child: Text(
                    '     payments history',
                    style: GoogleFonts.montserrat(color: Colors.white,fontSize: 15,),

                  )
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: const Color(0xFF00897b)),
          title: Text(
            'Fee payment',
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

        body : TabBarView(
          children: [
            Payfee(),
            Previousfee(),
            //Icon(Icons.directions_bike),
          ],
        ),

      ),
    );
  }
}

class Payfee extends StatefulWidget {
  @override
  _PayfeeState createState() => _PayfeeState();
}

class _PayfeeState extends State<Payfee> {

  Razorpay? razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlerPaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlerErrorFailure);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlerExternalWallet);
  }



  void openCheckout(){
    var options = {
      "key" : "rzp_live_fcOrwjSiVVdil3",
      "amount" : num.parse(textEditingController.text)*100,
      "name" : "vamsi",
      "description" : "Payment for the some random product",
      "prefill" : {
        "contact" : "6302986665",
        "email" : "vamsinaik123@gmail.com"
      },
      "external" : {
        "wallets" : ["paytm"]
      }
    };

    try{
    razorpay!.open(options);

    }catch(e){
    print(e.toString());
    }

  }

  void _handlerPaymentSuccess(PaymentSuccessResponse response){

    id= response.paymentId;
    status = "Payment sucess";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    time = formattedDate;
    print("Payment success");
    //Toast.show("Pament success", context);
    Fluttertoast.showToast(
        msg: "Payment successful" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: Color(0xFF00897b),
        textColor: Colors.white,
        fontSize: 16.0
    );

  }

  void _handlerErrorFailure(PaymentFailureResponse response){
    status = "Payment failed";
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    time = formattedDate;
    print("Payment error");
    Fluttertoast.showToast(
        msg: "Payment failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );



  }

  void _handlerExternalWallet(ExternalWalletResponse response){
    print("External Wallet");
    Fluttertoast.showToast(
        msg: "External Wallet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:<Widget> [

        Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 62),
          child: Column(
            children: [

              SizedBox(
                height: 30,
                child: Text(
                  'Your ID',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 45,
                padding:
                EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                child: TextFormField(

                  initialValue: "202100123",

                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: 'enter your ID number',

                    icon: Icon(
                      Icons.perm_identity,
                      color: const Color(0xFF00897b),
                    ),



                  ),

                ),
              ),

              SizedBox(height: 30,),

              SizedBox(
                height: 30,
                child: Text(
                  'Amount to be paid (in Rs)',
                  style: GoogleFonts.montserrat(color: Colors.black,fontSize: 15,),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 45,
                padding:
                EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                child: TextFormField(
                 // initialValue: "1500",
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: 'Your fee amount',
                    icon: Icon(
                      Icons.payments,
                      color: const Color(0xFF00897b),
                    ),

                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {

                  openCheckout();

                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 3.0,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF00897b),
                          const Color(0xFF00897b),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Center(
                    child: Text(
                      'Pay'.toUpperCase(),
                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 16,),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}

class Previousfee extends StatefulWidget {
  @override
  _PreviousfeeState createState() => _PreviousfeeState();
}

class _PreviousfeeState extends State<Previousfee> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            'Student ID- 202100123}\n',
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 20,),
          ),
          subtitle: Text(
            'Transaction time-${time ?? '--'}\n\nStatus - ${status ?? ' --'}\n\nLeave application url-\n ${id ?? '--'}' ,
            style: GoogleFonts.montserrat(color: Colors.black,fontSize: 18,),
          ),
        );
      },
    );
  }
}
