// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:untitled3/Language.dart';
import 'package:untitled3/cart/OrderStatu.dart';

import 'HomePage.dart';
import '../ProfilePage.dart';

class SwapScreens extends StatefulWidget {
  const SwapScreens({super.key});

  @override
  State<StatefulWidget> createState() => SwapScreensState();
}

class SwapScreensState extends State {
  int currentIndex = 0;
  List<Widget> Screens = [
    const HomePage(),
    const OrderStatu(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Screens[currentIndex],
        bottomNavigationBar: _BottomBar(),
      ),
    );
  }

  Widget _BottomBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          label: Language.isEn ?'home':"الرئيسية",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label:  Language.isEn ?'Cart':"السلة",
          icon: Icon(Icons.add_shopping_cart),
        ),
        BottomNavigationBarItem(label: Language.isEn ? 'profile':"الحساب", icon: Icon(Icons.person)),],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      selectedFontSize: 18,
      backgroundColor: Colors.grey.shade100,
      selectedItemColor: const Color.fromRGBO(0, 186, 175, 1),
    );
  }
}
