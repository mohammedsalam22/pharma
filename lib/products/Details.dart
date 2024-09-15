// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:untitled3/products/informations.dart';
import 'package:untitled3/token.dart';
import 'dart:convert';

import '../Language.dart';
import '../api.dart';

class Details extends StatefulWidget {
  const Details(
      {Key? key,
      required this.id,
      required this.scientific_name,
      required this.productname,
      required this.manufacturer,
      required this.date, required  this.price, required  this.quantity})
      : super(key: key);
  final int id;
  final String scientific_name;
  final String productname;
  final String manufacturer;
  final String date;
  final String price;
  final int quantity;

  @override
  State<Details> createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  final List<informations> products = [];
  @override
  Widget build(BuildContext context) {
    // return Center(child: Text('hello'),);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // width: 45,
                    // height: 45,
                    decoration: const BoxDecoration(
                        // color: Color.fromRGBO(0, 186, 175,1)
                        ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          // color: Colors.white,
                          color: Color.fromRGBO(0, 186, 175, 1),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop() ;
                        },
                      ),
                    ),
                  ),
                  Text(
                    Language.isEn ?'Medicine Details' : "تفاصيل الادوية",
                    style: TextStyle(
                        color: Color.fromRGBO(0, 186, 175, 1), fontSize: 22),
                  ),
                  Container(
                    // width: 45,
                    // height: 45,
                    decoration: const BoxDecoration(
                        // color: Color.fromRGBO(0, 186, 175,1),
                        // borderRadius: BorderRadius.circular(7)
                        ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          // color: Colors.white,
                          color: Color.fromRGBO(0, 186, 175, 1),
                          size: 28,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // width: double.infinity,
                height: MediaQuery.of(context).size.height / 2.8,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(85),
                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: const Image(
                    image: AssetImage(
                        '.idea/assets/images/e6b2310f8a7530c59f9df3e8476b59b6.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Com. Name':"الاسم",
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            color: Color.fromRGBO(0, 186, 175, 1),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.productname,
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),
                          //

                          style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              // color: Color.fromRGBO(0, 186, 175, 1)
                              color: Colors.black87))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Company':"الشركة",
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              color: Color.fromRGBO(0, 186, 175, 1))),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                       widget.manufacturer,
                        style: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            // color: Color.fromRGBO(0, 186, 175, 1)
                            color: Colors.black87),

                        // style: theme.textTheme.displaySmall
                        //     ?.copyWith(color: theme.colorScheme.secondary),
                      )
                    ],
                  ),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Sci. Name':"الاسم",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              color: Color.fromRGBO(0, 186, 175, 1))),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.scientific_name,
                          style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.w500,
                              // color: Color.fromRGBO(0, 186, 175, 1)
                              color: Colors.black87))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Expired Date':"تاريخ الانتهاء",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            color: Color.fromRGBO(0, 186, 175, 1),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.date,
                          style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              // color: Color.fromRGBO(0, 186, 175, 1)
                              color: Colors.black87))
                    ],
                  ),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Medicine Type':"نوع الدواء",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              color: Color.fromRGBO(0, 186, 175, 1))),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Pain reliever',
                        style: TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            // color: Color.fromRGBO(0, 186, 175, 1)
                            color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 4,
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const ReadMoreText(
                'learns valuable lessons about the difference between assets and liabilities, the power of financial education, and the importance of taking calculated risks. fhdsajh fdhasjk ajkdsfhdfsa  jkhdasf  ',
                textAlign: TextAlign.justify,
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'more',
                trimExpandedText: 'less',
                lessStyle: TextStyle(
                    color: Color.fromRGBO(0, 186, 175, 1),
                    fontWeight: FontWeight.bold),
                moreStyle: TextStyle(
                    color: Color.fromRGBO(0, 186, 175, 1),
                    fontWeight: FontWeight.bold),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Open_Sans',
                    color: Colors.black),
                //   ),

                //   ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Price' : "السعر",
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),

                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            color: Color.fromRGBO(0, 186, 175, 1),
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.price.toString(),
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),
                          //

                          style: const TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              // color: Color.fromRGBO(0, 186, 175, 1)
                              color: Colors.black87))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Language.isEn ?'Amount ': "الكمية",
                          // style: theme.textTheme.displaySmall
                          //     ?.copyWith(color: theme.colorScheme.secondary),
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open_Sans',
                              color: Color.fromRGBO(0, 186, 175, 1))),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'Open_Sans',
                            color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              // padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              width: MediaQuery.of(context).size.width / 1.5,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  // color: theme.colorScheme.secondary,
                  color: const Color.fromRGBO(0, 186, 175, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () async {
                            if (fav) {
                              print(1) ;
                              await addFav();
                            } else {
                              print(2) ;
                              await addFav() ;
                            }
                            setState(() {
                              fav = !fav ;
                            });
                          },
                          icon: const Icon(
                            Icons.favorite,
                            size: 28,
                            // color: theme.primaryColor,
                            color: Colors.white,
                          )),
                      Text(
                        Language.isEn ?'Add To Fav.' : "الاضافة الى المفضلة",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Open_Sans',
                            color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
  
  Future addFav() async{
    var response = await http.post(
      Uri.parse('${Api.api}/favorite'),
        headers: {
          "Accept": "application/json",
          'Authorization' : 'Bearer ${Token.token}',
        } ,
      body: {
        'product_id' : '${widget.id}' ,
      }
    ) ;
    print(response.body) ;
    if(response.statusCode == 200) {
      print(response.body) ;
      return response.body ;
    }
  }

  // Future removeFav() async{
  //   var response = await http.delete(
  //     Uri.parse('${Api.api}/favorite/${widget.id}'),
  //       headers: {
  //         "Accept": "application/json",
  //         'Authorization' : 'Bearer ${Token.token}',
  //       } ,
  //   ) ;
  //   print(response.body) ;
  //   if(response.statusCode == 200) {
  //     print(response.body) ;
  //     return response.body ;
  //   }
  // }
}
