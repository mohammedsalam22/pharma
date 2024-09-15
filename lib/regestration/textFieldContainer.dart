
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
var t=false;
var e=true;
///// بلا طعمة هي الماب
final Map<String, String> _authdata = {
  'name': '',
  'password': '',
  'phone-number': '',
  'location': ''
};
   Container buildContainerTextfield(
       double left,
       double right,
       double top,
       double bottom,
       String labelText,
       String hintText,
       suffixIcon,
       keyboardType,
       obscureText,
       String typeoffield,
       validator,
       controller) {
     return Container(
       padding:
       EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
       child: TextFormField(
         controller: controller,
         decoration: InputDecoration(
             border: const OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(20))),
             labelText: labelText,
             labelStyle: const TextStyle(
               fontSize: 19,
             ),
             hintText: hintText,
             hintStyle: const TextStyle(
               fontSize: 18,
             ),
             suffixIcon: suffixIcon),
         validator: validator,
         onSaved: (val) {
           _authdata[typeoffield] = val!;
           print(_authdata[typeoffield]);
         },
         style: const TextStyle(
           color: Colors.black,
         ),
         keyboardType: keyboardType,
         obscureText: obscureText,
       ),
     );
   }
