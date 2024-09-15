import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/api.dart';
import 'package:untitled3/cart/cart_list.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/token.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Future addF() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Token.token}'
    };
    var request = http.Request('POST', Uri.parse('${Api.api}/orders'));
    request.body = json.encode({
      "orderItems": CartList.cart.map((e) {
        return {
          'id': e['product'].id,
          'quantity': e['quantity'],
        };
      }).toList()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      CartList.cart.clear();
      CartList.cartLength = 0;
    } else {
      print(response.reasonPhrase);
    }
  }

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter == 1) {
      return;
    }
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Language.isEn ? 'carts' : 'السلة'),
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () async {
                await addF();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 186, 175, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  Language.isEn ? 'Make to order' : "القيام بالطلب",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: CartList.cart.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 0,
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
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          CartList.cart[index]['product']
                                              .productname,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          CartList.cart[index]['product'].price,
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
                                              onPressed: () {},
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
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10)
                                              ]),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              if (CartList.cart[index]
                                                      ['quantity'] ==
                                                  1) {
                                                return;
                                              }
                                              setState(() {
                                                CartList.cart[index]
                                                    ['quantity']--;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            '${CartList.cart[index]['quantity']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10)
                                              ]),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                CartList.cart[index]
                                                    ['quantity']++;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            CartList.cart.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
