// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:untitled3/Customshapes/Containers/ShapeCircularacontainer.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/cart/tabbar/screenone/ScreenOne.dart';

import '../Customshapes/Containers/curved_edges.dart';

class OrderStatu extends StatefulWidget {
  const OrderStatu({super.key});

  @override
  State<StatefulWidget> createState() => OrderStatuState();
}

class OrderStatuState extends State {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: Column(
            children: [
              ClipPath(
                  clipper: CustomCurvedEdges(),
                  child: Container(
                    color: const Color.fromRGBO(0, 186, 175, 1),
                    padding: const EdgeInsets.all(0),
                    child:  SizedBox(
                      height: 115,
                      child: Stack(
                        children: [
                          Positioned(
                              top: -310,
                              left: -270,
                              child: ShapeCircularacontainer()),
                          Positioned(
                              top: 170,
                              left: -270,
                              child: ShapeCircularacontainer()),
                          Positioned(
                              top: 170,
                              right: -270,
                              child: ShapeCircularacontainer()),
                          Positioned(
                              top: -310,
                              right: -270,
                              child: ShapeCircularacontainer()),
                          Positioned(
                              top: 50,
                              left: 140,
                              child: Text(
                                Language.isEn ? 'My Orders' :"طلباتي",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                  )),
              const Expanded(
                child: ScreenOne(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
