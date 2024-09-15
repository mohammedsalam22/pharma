// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/regestration/LoginDemo.dart';
import 'package:untitled3/token.dart';
import 'Customshapes/Containers/curved_edges.dart';
import 'regestration/textFieldContainer.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/api.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State {
  var jj;

  Future recantlyAdded() async {
    print('wait');
    try {
      var response = await http.get(Uri.parse('${Api.api}/user'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Token.token}'
      });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        jj = jsonDecode(response.body);
      } else {
        print('error');
      }
    } catch (NullPointerException) {
      print('sorry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: FutureBuilder(
          future: recantlyAdded(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
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
                            height: 280,
                            child: Stack(
                              children: [
                                const Positioned(
                                    top: 40,
                                    right: 30,
                                    child: Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                                Positioned(
                                    top: 40,
                                    left: 15,
                                    child: Text(
                                      Language.isEn ? 'Profile' : "حسابي",
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )),
                                //This widget for inserting the image
                                Positioned(
                                  top: 62,
                                  left: 128,
                                  child: Container(
                                    height: 160,
                                    width: 160,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 4,
                                            blurRadius: 5,
                                            blurStyle: BlurStyle.inner,
                                            color: Colors.white)
                                      ],
                                      color: Colors.white54,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            '.idea/assets/images/IMG_20210113_164625.jpg',
                                          )),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                  ),
                                  // color: Colors.white54,
                                ),
                                Positioned(
                                    top: 225,
                                    left: 90,
                                    child: Text(
                                      jj["name"],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        buildPadding(
                            Language.isEn ? 'Pharmacy name' : "اسم الصيدلية",
                            205),
                        buildContainerTextfield(
                            25,
                            25,
                            0,
                            0,
                            jj["pharmacy_name"],
                            'Enter your name',
                            null,
                            TextInputType.text,
                            t,
                            'pharmacy name', (val) {
                          if (val!.isEmpty) {
                            return 'insert your name';
                          }
                          return null;
                        }, null),
                        buildPadding(
                            Language.isEn ? 'Phone Number' : "رقمك الهاتفي",
                            214),
                        buildContainerTextfield(
                            25,
                            25,
                            0,
                            0,
                            jj["phone"],
                            'Enter your number',
                            null,
                            TextInputType.number,
                            t,
                            'phone-number', (val) {
                          if (val!.isEmpty || !val.length == 9) {
                            return 'invalid phone number';
                          }
                          return null;
                        }, null),
                        buildPadding(
                            Language.isEn ? 'Location' : "الموقع", 265),
                        buildContainerTextfield(
                            25,
                            25,
                            0,
                            0,
                            jj['address'],
                            Language.isEn
                                ? 'Enter Your location'
                                : "ادخل موقعك",
                            null,
                            TextInputType.text,
                            t,
                            'email', (val) {
                          if (val!.isEmpty || !val.contains('/')) {
                            return 'wrong location';
                          }
                          return null;
                        }, null),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Language.isEn = true;
                                            });
                                          },
                                          child: Text(Language.isEn
                                              ? 'English'
                                              : "الانجليزية")),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              Language.isEn = false;
                                            });
                                          },
                                          child: Text(Language.isEn
                                              ? 'Arabic'
                                              : "العربية")),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            alignment: Alignment.topLeft,
                            child: Text(
                              Language.isEn ? 'Language' : "اللغة",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                              "___________________________________________",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 186, 175, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                Language.isEn ? 'Log_out' : "تسجيل الخروج",
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 186, 175, 1)),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: TextButton(
                                    onPressed: () {
                                      delete_data();
                                      Get.offAll(const LoginDemo());
                                    },
                                    child: const Icon(
                                      Icons.logout,
                                      size: 37,
                                      color: Color.fromRGBO(0, 186, 175, 1),
                                    )))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> delete_data() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('access_token');
    Token.token = '';
  }

  Padding buildPadding(String text, double right) {
    return Padding(
        padding: EdgeInsets.only(right: right, top: 15, bottom: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
        ));
  }
}
