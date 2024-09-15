// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/cart/CartItem.dart';
import 'package:untitled3/products/Details.dart';
import 'package:untitled3/Homepage/HomePage.dart';
import 'package:untitled3/cart/cart_list.dart';
import 'package:untitled3/products/informations.dart';
import '../Customshapes/Containers/curved_edges.dart';
import 'package:http/http.dart' as http;

import '../Language.dart';
import '../api.dart';
import '../token.dart';

class Products extends StatefulWidget {
  const Products({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() => ProductsState();
}

class ProductsState extends State<Products> {
  final List<String> images = [
    '.idea/assets/images/b95246bd3685686e89906b46cb8a5675.jpg',
    '.idea/assets/images/d9ae586b078727c76438483c0fb0317e.jpg',
    '.idea/assets/images/52ab181a957351b9e144d145321c9c7e.jpg',
    '.idea/assets/images/a62dd8a7c2c8b017303d4084ba904325.jpg',
    '.idea/assets/images/b2c14ce9c880e011f0255537acbd1e13.jpg',
  ];
  final List<informations> products = [];
  int increment = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  Future Product() async {
    print('wait');
    try {
      var response = await http.get(Uri.parse('${Api.api}/get_product/${widget.id}'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Token.token}'
      });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsd = jsonDecode(response.body)['data']['products'];
        products.clear();
        for (int i = 0; i < jsd.length; i++) {
          products.add(informations(
              id: jsd[i]['id'],
              scientific_name: jsd[i]['scientific_name'],
              date: jsd[i]['Date_of_validity'],
              manufacturer: jsd[i]['manufacturer'],
              image: jsd[i]['image'],
              productname: jsd[i]['trading_name'],
              price: jsd[i]['price'],
              quantity: jsd[i]['quantity']));
        }
        print(products.length);
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
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
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
                          right: 30,
                          child: Badge(
                            label: Text(CartList.cart.length.toString()),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                //
                                //  Get.to(put your cart class name here )
                                // Get.to(()=>CartItem(id: null,));
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CartItem(),
                                ));
                              },
                              icon: const Icon(
                                Icons.shopping_cart,
                                size: 30,
                              ),
                            ),
                          )),
                     Positioned(
                          top: 50,
                          left: 135,
                          child: Text(
                            Language.isEn ?'Medicine' : "الادوية",
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
            FutureBuilder(
              future: Product(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ...products.map((val) {
                        return SingleChildScrollView(
                            child: Card(
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Text(
                                            val.price.toString(),
                                            style: const TextStyle(
                                                color: Colors.grey, fontSize: 17),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: const EdgeInsets.only(),
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.to(() => Details(
                                                      id: val.id,
                                                      scientific_name:
                                                          val.scientific_name,
                                                      productname:
                                                          val.productname,
                                                      manufacturer:
                                                          val.manufacturer,
                                                      date: val.date,
                                                      price: val.price,
                                                      quantity: val.quantity));
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
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                height: 34,
                                                width: 110,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0, 186, 175, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5))),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                      const Color.fromRGBO(
                                                          0, 186, 175, 1),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // Get.snackbar('ap care',
                                                    //     'New item has been added',
                                                    //     colorText: Colors.white,
                                                    //     backgroundColor:
                                                    //     const Color.fromRGBO(
                                                    //         0, 186, 175, 1),
                                                    //     snackPosition:
                                                    //     SnackPosition.BOTTOM);
                                                    // setState(() {
                                                    //   increment += 1;
                                                    // });
                                                    setState(() {
                                                      CartList.cart.add({
                                                        'product': val,
                                                        'quantity': 1
                                                      });
                                                    });
                                                    print(CartList.cart);
                                                  },
                                                  child: const Text(
                                                    "Add to cart",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ))
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
            )
          ],
        ),
      )),
    );
  }
}
