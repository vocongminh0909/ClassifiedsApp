import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nhom4_appraovat/account_page.dart';
import 'package:nhom4_appraovat/shopping_cart_page.dart';

import 'home_page.dart';


class main_nav extends StatefulWidget {
  const main_nav({super.key});

  @override
  State<main_nav> createState() => _main_navState();
}

class _main_navState extends State<main_nav> {
 int _currentIndex = 0;
  final List<Widget> _screens = [
    HomePage(),   
    Shopping_cartPage(),
    AccountPage(),  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        color: Colors.orange,
        height: MediaQuery.of(context).size.height*0.08,
        backgroundColor: Colors.white10,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          }
          );
        },
        items: const [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          Icon(
            Icons.account_box,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}