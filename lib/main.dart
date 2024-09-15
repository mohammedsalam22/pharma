// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Homepage/SwapScreens.dart';
import 'package:untitled3/regestration/LoginDemo.dart';
import 'package:untitled3/token.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
   MyAppState createState()=>MyAppState();
  }
  class MyAppState extends State<MyApp> {
    Widget page = const LoginDemo();
    @override
  void initState() {
    super.initState();
    CheckLogIn();
  }
  void CheckLogIn() async{
      WidgetsFlutterBinding.ensureInitialized();
     // var token=Token.token;
      SharedPreferences prefe = await SharedPreferences.getInstance();
      var token = prefe.getString('access_token');
      if(token != null){
        setState(() {
          page = const SwapScreens();
        });
      }
      else {
        setState(() {
          page = const LoginDemo();
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
