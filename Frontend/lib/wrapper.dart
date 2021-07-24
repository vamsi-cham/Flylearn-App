import 'package:flutter/material.dart';
import 'package:smart_school/Student/Shome.dart';
import 'package:smart_school/Teacher/home.dart';
import 'package:smart_school/login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Data==null){
      return  Login();

    }else if(Data!=null && Data['data'][0]['role']=='teacher'){
      return  Home();

    }else{
      return SHome();

    }
  }
}
