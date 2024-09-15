import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/products/Details.dart';

import '../Customshapes/Containers/curved_edges.dart';
import '../cart/cart_list.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.products});

  final List products;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                  child: const SizedBox(
                    height: 130,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 50,
                            left: 135,
                            child: Text(
                              'Search',
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    ...widget.products.map((val) {
                      return SingleChildScrollView(
                          child: Card(
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10))),
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
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
                                                  color: Colors.grey,
                                                  fontSize: 17),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                padding: const EdgeInsets
                                                    .only(),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.to(Details(id: val.id,
                                                        scientific_name:
                                                        val.scientific_name,
                                                        productname:
                                                        val.productname,
                                                        manufacturer:
                                                        val.manufacturer,
                                                        date: val.date,
                                                        price: val.price,
                                                        quantity: val
                                                            .quantity));
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
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Container(
                                                  height: 34,
                                                  width: 110,
                                                  decoration: const BoxDecoration(
                                                      color:
                                                      Color.fromRGBO(
                                                          0, 186, 175, 1),
                                                      borderRadius: BorderRadius
                                                          .all(
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
                                                      style:
                                                      TextStyle(
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
              ),
            ],
          ),
        ));
  }
}
