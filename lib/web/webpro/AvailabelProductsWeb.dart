// // ignore: file_names
// // ignore_for_file: non_constant_identifier_names
//
// import 'package:flutter/material.dart';
//
// import '../Customshapes/Containers/curved_edges.dart';
// import '../informations.dart';
//
// class AvailabelProductsWeb extends StatefulWidget {
//   const AvailabelProductsWeb({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => AvailabelProductsWebState();
// }
//
// class AvailabelProductsWebState extends State<AvailabelProductsWeb> {
//   final List<informations> li = [
//     informations(
//
//         image: '.idea/assets/images/b95246bd3685686e89906b46cb8a5675.jpg',
//         price: '20',
//         productname: 'Halls red'),
//     informations(
//         image: '.idea/assets/images/d9ae586b078727c76438483c0fb0317e.jpg',
//         price: '30',
//         productname: 'Halls blue'),
//     informations(
//         image: '.idea/assets/images/52ab181a957351b9e144d145321c9c7e.jpg',
//         price: '10',
//         productname: 'Formula'),
//     informations(
//         image: '.idea/assets/images/a62dd8a7c2c8b017303d4084ba904325.jpg',
//         price: '40',
//         productname: 'vicks'),
//     informations(
//         image: '.idea/assets/images/b2c14ce9c880e011f0255537acbd1e13.jpg',
//         price: '50',
//         productname: 'pangolin'),
//     informations(
//         image: '.idea/assets/images/b2c14ce9c880e011f0255537acbd1e13.jpg',
//         price: '10',
//         productname: 'pana'),
//     informations(
//         image: '.idea/assets/images/b2c14ce9c880e011f0255537acbd1e13.jpg',
//         price: '20',
//         productname: 'Handel'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               ClipPath(
//                 clipper: CustomCurvedEdges(),
//                 child: Container(
//                   color: const Color.fromRGBO(0, 186, 175, 1),
//                   padding: const EdgeInsets.all(0),
//                   child: const SizedBox(
//                     height: 110,
//                     child: Stack(
//                       children: [
//                         Positioned(
//                             top: 40,
//                             left: 135,
//                             child: Text(
//                               'Your Order',
//                               style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               _ListViewProducts()
//             ],
//           ),
//         ));
//   }
//
//   Widget _ListViewProducts() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           ...li.map((val) {
//             return SingleChildScrollView(
//                 child: Card(
//                   color: Colors.white,
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   elevation: 0.5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Row(
//                           children: [
//                             Image(
//                               height: 110,
//                               width: 100,
//                               image: AssetImage(val.image.toString()),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     val.productname.toString(),
//                                     // ignore: prefer_const_constructors
//                                     style: TextStyle(
//                                         fontSize: 20, fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     val.price.toString(),
//                                     style: const TextStyle(
//                                         color: Colors.grey, fontSize: 17),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Container(
//                                       padding: const EdgeInsets.only(),
//                                       child: TextButton(
//                                         onPressed: () {},
//                                         child: const Text(
//                                           "Details...",
//                                           style: TextStyle(
//                                               color:
//                                               Color.fromRGBO(0, 186, 175, 1)),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ));
//           }).toList(),
//         ],
//       ),
//     );
//   }
// }
