// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Homepage/HomePage.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/api.dart';
import 'package:untitled3/regestration/LoginDemo.dart';
import 'package:untitled3/token.dart';
import '../Customshapes/Containers/ShapeCircularacontainer.dart';
import '../Customshapes/Containers/curved_edges.dart';
import '../Homepage/SwapScreens.dart';
import 'textFieldContainer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<StatefulWidget> createState() => SingupState();
}

Future register(String Pharmacy_name, String password, String name,
    String phonenumber, String address) async {
  print('wait');
  try {
    var response = await http.post(
        Uri.parse('${Api.api}/register'),
        body: <String, String>{
          'pharmacy_name': Pharmacy_name,
          'phone': phonenumber,
          'password': password.toString(),
          'name': name,
          'phone': phonenumber,
          'address': address,
        },
        headers: {
          "Accept": "application/json",
        });
    print('response is ${response.body}');
    print('response is ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsd = jsonDecode(response.body);
      Token.token = jsd['data']['access_token'];
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setString(key, value)

      Get.off(() => const SwapScreens());
    } else {
      var js = jsonDecode(response.body);
      var token = js['message'];
      print(token);
    }
  } catch (NullPointerException) {
    print('sorry');
  }
}

@override
class SingupState extends State<Singup> {
  final GlobalKey<FormState> _fromkey = GlobalKey();
  final PharmacyController = TextEditingController();
  final nameController = TextEditingController();
  final PhoneNumberController = TextEditingController();
  final PasswordController = TextEditingController();
  final addressController = TextEditingController();
  var e = true;
  var t = false;
  var m = 'isEmpty'.toString();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
        children: [
          ClipPath(
            clipper: CustomCurvedEdges(),
            child: Column(
              children: [
                Container(
                  color: const Color.fromRGBO(0, 186, 175, 1),
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        const Positioned(
                            top: -220,
                            left: 300,
                            child: ShapeCircularacontainer()),
                        const Positioned(
                            top: 80, left: 300, child: ShapeCircularacontainer()),
                        Positioned(
                            top: 100,
                            right: 130,
                            child: Text(
                              Language.isEn ? 'SingUp' : "تسجيل الدخول" ,
                              style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                        Positioned(
                            top: 160,
                            right: 100,
                            child: Text(
                              Language.isEn ?'create new account' : "انشاء حساب جديد",
                              style:
                                  const TextStyle(fontSize: 25, color: Colors.white54),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
              key: _fromkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildContainerTextfield(
                        22,
                        22,
                        20,
                        0,
                        Language.isEn ?'UserName':"اسم المستخدم",
                        Language.isEn ?'Enter your name':"ادخل اسمك",
                        null,
                        TextInputType.text,
                        t,
                        'name', (val) {
                      if (val!.isEmpty) {
                        return 'insert your name';
                      }
                      return null;
                    }, nameController),
                    buildContainerTextfield(
                        22,
                        22,
                        10,
                        0,
                        Language.isEn ?'Pharmacy Name':"اسم الصيدلية",
                        Language.isEn ?'Enter your Pharmacy name':"ادخل اسم الصيدلية",
                        null,
                        TextInputType.text,
                        t,
                        'pharmacy name', (val) {
                      if (val!.isEmpty) {
                        return 'insert your name';
                      }
                      return null;
                    }, PharmacyController),
                    buildContainerTextfield(
                        22,
                        22,
                        10,
                        0,
                        Language.isEn ?'Password' :"كلمة المرور",
                        Language.isEn ?'Enter Your Password':"ادخل كلمة المرور",
                        IconButton(
                          icon: (Icon(
                            e ? Icons.visibility : Icons.visibility_off,
                          )),
                          onPressed: () {
                            setState(() {
                              e = !e;
                            });
                          },
                          color: const Color.fromRGBO(0, 186, 175, 1),
                        ),
                        TextInputType.visiblePassword,
                        e,
                        'password', (val) {
                      if (val!.isEmpty || val.length <= 5) {
                        return 'too short password';
                      }
                      return null;
                    }, PasswordController),
                    buildContainerTextfield(
                        22,
                        22,
                        10,
                        0,
                        Language.isEn ?'Phone Number':"رقم الهاتف",
                        Language.isEn ?'Enter your number':"ادخل رقمك",
                        null,
                        TextInputType.number,
                        t,
                        'phone-number', (val) {
                      if (val!.isEmpty || !val.length == 9) {
                        return 'invalid phone number';
                      }
                      return null;
                    }, PhoneNumberController),
                    buildContainerTextfield(
                        22,
                        22,
                        10,
                        0,
                        Language.isEn ?'Location':"موقعك",
                        Language.isEn ?'Enter Your location':"ادخل موقعك",
                        null,
                        TextInputType.text,
                        t,
                        'email', (val) {
                      if (val!.isEmpty) {
                        return 'wrong location';
                      }
                      return null;
                    }, addressController),
                  ],
                ),
              )),
          Row(children: [
            Padding(
                padding: const EdgeInsets.only(right: 170, left: 30, top: 10),
                child: Text(
                  Language.isEn ?'Get Started':"هيا نبدأ",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 186, 175, 1)),
                )),
            TextButton(
                onPressed: () {
                    register(
                      PharmacyController.text,
                      PasswordController.text,
                      nameController.text,
                      PhoneNumberController.text,
                      addressController.text,
                    );

                },
                child: const Icon(
                  Icons.login,
                  size: 50,
                  color: Color.fromRGBO(0, 186, 175, 1),
                )),
          ]),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                Language.isEn ?'already have an account?':"لدي حساب بالفعل ؟ ",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              )),
          Container(
            width: 250,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(0, 186, 175, 1)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))))),
              onPressed: () {
                Get.off(const LoginDemo());
              },
              child: Text(
                Language.isEn ?'Login':"تسجيل الدخول",
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          )
        ],
      ))),
    );
  }
}
