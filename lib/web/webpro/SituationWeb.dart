// // ignore: file_names
// // ignore_for_file: non_constant_identifier_names
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webproject/web/AvailebelProducts.dart';
// import '../../Customshapes/Containers/curved_edges.dart';
// import '../api.dart';
// import 'AvailebelProducts.dart';
// import 'AvailabelProductsWeb.dart';
// import 'infoemationWeb.dart';
// import 'package:http/http.dart' as http;
//
// class SituationWeb extends StatefulWidget {
//   const SituationWeb({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => SituationWebState();
// }
//
// class SituationWebState extends State<SituationWeb> {
//   final List<ScreensInfo> li = [];
//
//   Future register() async {
//     print('wait');
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       var Token = preferences.getString('access_token');
//       var response = await http.get(Uri.parse('${Api.api}/admin/orders'),
//           headers: {
//             "Accept": "application/json",
//             'Authorization': 'Bearer $Token'
//           });
//       print('response is ${response.body}');
//       print('response is ${response.statusCode}');
//       if (response.statusCode == 200) {
//         var r = jsonDecode(response.body)["data"];
//         li.clear();
//         for (int i = 0; i < r.length; i++) {}
//       } else {
//         print('errrrrrror');
//       }
//     } catch (NullPointerException) {
//       print('sorry');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           ClipPath(
//               clipper: CustomCurvedEdges(),
//               child: Container(
//                 color: const Color.fromRGBO(0, 186, 175, 1),
//                 padding: const EdgeInsets.all(0),
//                 child: const SizedBox(
//                   height: 80,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                           top: 20,
//                           left: 570,
//                           child: Text(
//                             'Order Status',
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           )),
//                     ],
//                   ),
//                 ),
//               )),
//           FutureBuilder(
//             future: register(),
//             builder: (context, snapshot) {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height,
//                       padding: const EdgeInsets.only(left: 10, right: 10),
//                       child: GridView(
//                         gridDelegate:
//                             const SliverGridDelegateWithMaxCrossAxisExtent(
//                           maxCrossAxisExtent: 350,
//                           mainAxisExtent: 220,
//                           childAspectRatio: 12 / 18,
//                           crossAxisSpacing: 5,
//                           mainAxisSpacing: 5,
//                         ),
//                         children: [
//                           ...li.map((val) {
//                             return Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Get.to(AvailabelProducts(
//                                         product: val.products,
//                                         quantity: val.quantitiy));
//                                   },
//                                   child: Card(
//                                     shape: const RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15))),
//                                     elevation: 3,
//                                     color: Colors.white,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(15),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               const SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   const SizedBox(
//                                                     height: 10,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             bottom: 5),
//                                                     child: Text(
//                                                       'Order number: ${val.ordernumber}',
//                                                       style: const TextStyle(
//                                                           fontSize: 18),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     'Total price: ${val.price.toString()}',
//                                                     style: const TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 18),
//                                                   ),
//                                                   Text(
//                                                     'Order Statu: ${val.orderstatue}',
//                                                     style: const TextStyle(
//                                                         fontSize: 12),
//                                                   )
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 width: 15,
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             bottom: 5),
//                                                     child: Text(
//                                                       'quantity: ${val.quantitiy}',
//                                                       style: const TextStyle(
//                                                           fontSize: 18),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     val.date.substring(0, 10),
//                                                     style: const TextStyle(
//                                                         fontSize: 18),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   setState(() async {
//                                                     await update(int.parse(
//                                                         val.ordernumber));
//                                                   });
//                                                 },
//                                                 child: const Text(
//                                                   'In Preparation',
//                                                   style: TextStyle(
//                                                     fontSize: 18,
//                                                     color: Color.fromRGBO(
//                                                         0, 186, 175, 1),
//                                                   ),
//                                                 ),
//                                               ),
//
//                                               // TextButton(
//                                               //     onPressed: () {},
//                                               //     child: const Text(
//                                               //       'In Preparation',
//                                               //       style: TextStyle(
//                                               //           fontSize: 18,
//                                               //           color: Color.fromRGBO(
//                                               //               0, 186, 175, 1)),
//                                               //     )),
//                                               TextButton(
//                                                   onPressed: () {},
//                                                   child: const Text(
//                                                     'Done',
//                                                     style: TextStyle(
//                                                         fontSize: 17,
//                                                         color: Color.fromRGBO(
//                                                             0, 186, 175, 1)),
//                                                   )),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Future update(int orderId) async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       var Token = preferences.getString('access_token');
//       var response = await http.put(
//         Uri.parse('${Api.api}/admin/orders/$orderId'),
//         headers: {
//           "Accept": "application/json",
//           'Authorization': 'Bearer $Token',
//         },
//         body: {
//           "order_status": "تم التسليم",
//         },
//       );
//
//       print('Update response is ${response.body}');
//       print('Update response code is ${response.statusCode}');
//
//       if (response.statusCode == 200) {
//         print('Update response is ${response.body}');
//         return response.body;
//       } else {
//         print('Error updating status');
//       }
//     } catch (e) {
//       print('Exception: $e');
//     }
//   }
//
//   SizedBox buildContainer(String text) {
//     return SizedBox(
//       height: 37,
//       width: 170,
//       child: ElevatedButton(
//         style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all(const Color.fromRGBO(0, 186, 175, 1)),
//             shape: MaterialStateProperty.all(const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10))))),
//         onPressed: () {},
//         child: Text(
//           text,
//           style: const TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
