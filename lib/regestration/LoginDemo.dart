// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/Homepage/SwapScreens.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/api.dart';
import 'package:untitled3/token.dart';
import 'textFieldContainer.dart';
import 'Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

Future login(String phonenumber, String password) async {
  print('wait');
  try {
    var response = await http.post(
        Uri.parse('${Api.api}/login'),
        body: <String, String>{
          'phone': phonenumber,
          'password': password,
        },
        headers: {
          "Accept": "application/json",
        });
    print('response is ${response.body}');
    print('response is ${response.statusCode}');
    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);
      Token.token = js['data']['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', js.toString());
      Get.off(() => SwapScreens());
    } else {
      var js = jsonDecode(response.body);
      var token = js['message'];
      print(token);
    }
  } catch (NullPointerException) {
    print('sorry');
  }
}

class _LoginDemoState extends State<LoginDemo> {
  final GlobalKey<FormState> _fromkey = GlobalKey();
  final PhoneNumberController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _fromkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                      ".idea/assets/images/2f56c4da6df27a4360de037de748b8c2.jpg"),
                ),
                SizedBox(
                  height: 29,
                ),
                buildContainerTextfield(
                  19,
                  19,
                  20,
                  10,
                  Language.isEn ? 'Phone Number' : 'رقم الهاتف',
                  Language.isEn ? 'Enter your number' : "ادخل رقم هاتفك",
                  null,
                  TextInputType.number,
                  t,
                  'phone-number',
                      (val) {
                    // ignore: unrelated_type_equality_checks
                    if (val!.isEmpty || val.length < 10) {
                      return 'invalid phone number';
                    }
                    return null;
                  },
                  PhoneNumberController,
                ),
                buildContainerTextfield(
                  19,
                  19,
                  20,
                  0,
                  'Password'
                      'Enter Your Password',
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
                  'password',
                      (val) {
                    if (val!.isEmpty || val.length <= 7) {
                      return Language.isEn
                          ? 'too short password'
                          : "كلمة مرور قصيرة";
                    }
                    return null;
                  },
                  PasswordController,
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  height: 90,
                  width: 230,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(0, 186, 175, 1)),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))))),
                    onPressed: () {
                      if (_fromkey.currentState!.validate()) {
                        login(
                            PhoneNumberController.text,
                            PasswordController.text);
                      } else {
                        Get.snackbar('ap care', 'you missed something',
                            duration: Duration(seconds: 2),
                            colorText: Colors.white,
                            backgroundColor: Color.fromRGBO(0, 186, 175, 1),
                            snackStyle: SnackStyle.FLOATING);
                      }
                      //  Get.off(const SwapScreens());
                    },
                    child: Text(
                      Language.isEn ? 'Login' : "تسجيل دخول",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7, top: 25),
                      child: Text(
                        Language.isEn ? ' New user?' : "مستخدم جديد؟",
                        style:
                        TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: TextButton(
                          onPressed: () {
                            Get.off(Singup());
                          },
                          child: Text(
                            Language.isEn ? 'Create an account' : "انشاء حساب",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Color.fromRGBO(0, 186, 175, 1)),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
