// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../../Customshapes/Containers/curved_edges.dart';

class AvailabelProducts extends StatefulWidget {
  const AvailabelProducts(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);

  final List product;

  final List quantity;

  @override
  State<StatefulWidget> createState() => AvailabelProductsState();
}

class AvailabelProductsState extends State<AvailabelProducts> {
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
                height: 110,
                child: Stack(
                  children: [
                    Positioned(
                        top: 40,
                        left: 135,
                        child: Text(
                          'Your Order',
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
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.product.map((val) {
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                val["trading_name"].toString(),
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                val['price'].toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 17),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'quantity is ${widget.quantity[widget.product.indexOf(val)]}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 17),
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
  }
}
