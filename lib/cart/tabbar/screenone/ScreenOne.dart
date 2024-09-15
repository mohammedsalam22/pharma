// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled3/cart/AvailabelProducts.dart';

import '../../../Language.dart';
import '../../../api.dart';
import '../../../token.dart';
import '../ScreensInfo.dart';
import 'package:http/http.dart' as http;

class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ScreenOneState();
}

class ScreenOneState extends State<ScreenOne> {
  String statu = 'paid';
  final List<ScreensInfo> li = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [_ListViewProducts()],
      ),
    ));
  }

  Widget _ListViewProducts() {
    return FutureBuilder(
        future: register(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ...li.map((val) {
                  return SingleChildScrollView(
                      child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            elevation: 1,
                            color: Colors.white,
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
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Text(
                                                Language.isEn ?'Order number: ${val.ordernumber}' :'رقم الطلب : ${val.ordernumber}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                            Text(
                                              Language.isEn ?'Total price: ${val.price.toString()}':'السعر الكلي : ${val.price.toString()}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              Language.isEn ? 'financial statu: ${val.financialStatu}' : 'الحالة المالية : ${val.financialStatu}',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            val.orderstatue,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            val.date.substring(0, 10),
                                            style:
                                                const TextStyle(fontSize: 18),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Get.to(() => AvailabelProducts(product: val.products,quantity: val.quantitiy,));
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color:
                                                Color.fromRGBO(0, 186, 175, 1),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
                }).toList(),
              ],
            ),
          );
        });
  }

  Future register() async {
    print('wait');
    try {

      var response = await http.get(Uri.parse('${Api.api}/orders'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer ${Token.token}'
      });
      print('response is ${response.body}');
      print('response is ${response.statusCode}');
      if (response.statusCode == 200) {
        var r = jsonDecode(response.body)["data"];
        li.clear();
        for (int i = 0; i < r.length; i++) {
          li.add(ScreensInfo(
            date: r[i]['created_at'],
            price: r[i]['total'].toString(),
            financialStatu: 'un paid',
            ordernumber: r[i]['id'].toString(),
            orderstatue:  r[i]['order_status'],
            quantitiy: r[i]['quantity_items'],
            products: r[i]['product'],
          ));
        }
      } else {
        print('errrrrrror');
      }
    } catch (NullPointerException) {
      print('sorry');
    }
  }
}
