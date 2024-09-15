// Future favorite() async {
//   print('wait');
//   try {
//     var response = await http.get(Uri.parse('${Api.api}/favorite'), headers: {
//       "Accept": "application/json",
//     });
//     print('response is ${response.body}');
//     print('response is ${response.statusCode}');
//     if (response.statusCode == 200) {
//       var jsd = jsonDecode(response.body)['data'];
//       for (int i = 0; i < jsd.length; i++) {
//         favorites.add(FavoriteInfo(
//           id: jsd[i]['id'],
//           image: jsd[i]['is_favorite'],
//           productname: jsd[i]['trading_name'],
//           price: jsd[i]['price'],
//         ));
//       }
//       print(favorites.length);
//       print(jsd.length);
//     } else {
//       print('error');
//     }
//   } catch (NullPointerException) {
//     print('sorry');
//   }
// }
// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/FavoriteItem/FavoriteInfo.dart';
import 'package:untitled3/Homepage/HomePage.dart';
import 'package:untitled3/products/informations.dart';
import 'package:untitled3/token.dart';
import '../../Customshapes/Containers/curved_edges.dart';
import 'package:http/http.dart' as http;

import '../../api.dart';
import '../Language.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FavoriteState();
}

class FavoriteState extends State<Favorite> {
  final List<String> images = [
    '.idea/assets/images/b95246bd3685686e89906b46cb8a5675.jpg',
    '.idea/assets/images/d9ae586b078727c76438483c0fb0317e.jpg',
    '.idea/assets/images/52ab181a957351b9e144d145321c9c7e.jpg',
    '.idea/assets/images/a62dd8a7c2c8b017303d4084ba904325.jpg',
    '.idea/assets/images/b2c14ce9c880e011f0255537acbd1e13.jpg',
  ];
  final List<FavoriteInfo> favorites = [];
  int increment = 0;

  Future fav() async {
    print('wait');
    try {

      var response = await http.get(Uri.parse('${Api.api}/favorite'), headers: {
        "Accept": "application/json",
        'Authorization' : 'Bearer ${Token.token}',
      });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsd = jsonDecode(response.body)['data'];
        favorites.clear();
        for (int i = 0; i < jsd.length; i++) {
          favorites.add(FavoriteInfo(
              productname: jsd[i]['trading_name'],
              ));
        }
        print(favorites.length);
        print(jsd.length);
      } else {
        print('error');
      }
    } catch (NullPointerException) {
      print('sorry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: CustomCurvedEdges(),
            child: Container(
              color: const Color.fromRGBO(0, 186, 175, 1),
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 130,
                child: Stack(
                  children: [
                    Positioned(
                        top: 50,
                        left: 135,
                        child: Text(
                          Language.isEn ?'Medicine' : "ادوية",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),
          _ListViewProducts()
        ],
      ),
    ));
  }

  Widget _ListViewProducts() {
    return FutureBuilder(
      future: fav(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              ...favorites.map((val) {
                return SingleChildScrollView(
                    child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    val.productname,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  // Text(
                                  //   val.price.toString(),
                                  //   style: const TextStyle(
                                  //       color: Colors.grey, fontSize: 17),
                                  // ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: const EdgeInsets.only(),
                                      child: TextButton(
                                        onPressed: () {

                                        },
                                        child: const Text(
                                          "Details...",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  0, 186, 175, 1)),
                                        ),
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
