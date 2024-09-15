// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/products/Details.dart';
import 'package:untitled3/Homepage/recantlyAddedInfo.dart';
import 'package:untitled3/products/Products.dart';
import 'package:untitled3/Homepage/search.dart';
import '../Customshapes/Containers/ShapeCircularacontainer.dart';
import '../Customshapes/Containers/curved_edges.dart';
import '../FavoriteItem/Favorite.dart';
import '../Language.dart';
import '../api.dart';
import '../products/informations.dart';
import '../token.dart';
import 'categoryinfo.dart';
import 'recantlyAddedInfo.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}
class HomePageState extends State {
  final List<recantlyAddedInfo> names = [];
  final List<categoryinfo> li = [];
  Future categories() async {
    print('wait');
    try {
      var response = await http.get(Uri.parse('${Api.api}/categories'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Token.token}'
          });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        var js = jsonDecode(response.body)['data'];
        li.clear();
        for (int i = 0; i < js.length; i++) {
          li.add(categoryinfo(
              category_image: js[i]['image'],
              category_name: js[i]['name'],
              id: js[i]['id']));
        }
        print(li.length);
        print(js.length);
      } else {
        print('error');
      }
    } catch (NullPointerException) {
      print('sorry');
    }
  }
  Future recantlyAdded() async {
    print('wait');
    try {
      var response = await http.get(Uri.parse('${Api.api}/addedRecently'),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer ${Token.token}'
          });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsd = jsonDecode(response.body)['data'];
        names.clear();
        for (int i = 0; i < jsd.length; i++) {
          names.add(recantlyAddedInfo(
              id: jsd[i]['id'],
              scientific_name: jsd[i]['scientific_name'],
              date: jsd[i]['Date_of_validity'],
              manufacturer: jsd[i]['manufacturer'],
              image: jsd[i]['image'],
              productname: jsd[i]['trading_name'],
              price: jsd[i]['price'],
              isfavorite: jsd[i]['is_favorite'],
              quantity: jsd[i]['quantity']));
        }
        print(li.length);
        print(jsd.length);
      } else {
        print('error');
      }
    } catch (Exception ) {
      print(Exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  Language.isEn ? TextDirection.ltr : TextDirection.rtl,
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
                        height: 400,
                        child: Stack(
                          children: [
                            const Positioned(
                                top: -150,
                                right: -250,
                                child: ShapeCircularacontainer()),
                            const Positioned(
                                top: 100,
                                right: -300,
                                child: ShapeCircularacontainer()),
                            Positioned(
                                top: 40,
                                right: 30,
                                child: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Get.to(() => const Favorite());
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 30,
                                  ),
                                )),

                            Positioned(
                                top: 40,
                                left: 15,
                                child: Text(
                                  Language.isEn ?'Get your medicine':"اجلب ادويتك",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )),
                            Positioned(
                                top: 70,
                                left: 20,
                                child: Text(
                                  Language.isEn ?'All that you need' :"كل ماتحتاجه",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white70),
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 130, left: 24, right: 24),
                                child: _SearchTextField()),
                            Positioned(
                              top: 210,
                              left: 20,
                              child: Text(
                                Language.isEn ?'Recently added':"المضاف حديثا",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 250, left: 17, right: 6),
                                child: _ListViewRecentlyAdded()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 246, bottom: 10),
                child: Text(
                    Language.isEn ?'Categories':"التصنيفات",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 186, 175, 1)),
                ),
              ),
              FutureBuilder(
                  future: categories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Container(
                      height: 350,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 140,
                          mainAxisExtent: 160,
                          childAspectRatio: 4 / 5,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        children: [
                          ...li.map((val) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => Products(
                                      id: val.id,
                                    ));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Image(
                                      height: 80,
                                      width: 90,
                                      image: AssetImage(
                                          '.idea/assets/images/e6b2310f8a7530c59f9df3e8476b59b6.jpg'),
                                    ),
                                    Text(
                                      val.category_name.toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SearchTextField() {
    var c = TextEditingController();
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: TextField(
            controller: c,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: Language.isEn ?'Search' : "البحث",
                prefixIcon: IconButton(
                    onPressed: () async {
                      List ll = [];
                      print(c.text);
                      var response = await http.get(
                          Uri.parse('${Api.api}/search_product?trading_name= ${c.text}'),
                          headers: {
                            "Accept": "application/json",
                            'Authorization': 'Bearer ${Token.token}'
                          },
                          );
                      print('response is ${response.body}');
                      print('response is ${response.statusCode}');
                      if (response.statusCode == 200) {
                        var jsd = jsonDecode(response.body)['data'];
                          ll.add(informations(
                              id: jsd['id'],
                              scientific_name: jsd['scientific_name'],
                              date: jsd['Date_of_validity'],
                              manufacturer: jsd['manufacturer'],
                              image: jsd['image'],
                              productname: jsd['trading_name'],
                              price: jsd['price'],
                              quantity: jsd['quantity']));

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Search(products: ll),
                        ));
                      } else {
                        print('error');
                      }
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(0, 186, 175, 1),
                    )),
                labelStyle: const TextStyle())));
  }

  _ListViewRecentlyAdded() {
    return FutureBuilder(
      future: recantlyAdded(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return SizedBox(
          height: 140,
          child: ListView.separated(
            itemCount: names.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    height: 86,
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        '.idea/assets/images/e6b2310f8a7530c59f9df3e8476b59b6.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(Details(
                          id: names[index].id,
                          scientific_name: names[index].scientific_name,
                          productname: names[index].productname,
                          manufacturer: names[index].manufacturer,
                          date: names[index].date,
                          price: names[index].price,
                          quantity: names[index].quantity));
                    },
                    child: Text(
                      names[index].productname,
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 17,
            ),
          ),
        );
      },
    );
  }
}
