import 'package:flutter/material.dart';

import '../widgets/product_list.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentPage=0;
  List<Widget> pages=[
    const ProductList(),
    const CartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
          onTap: (value){
          setState(() {
            currentPage=value;
          });
          },
        currentIndex: currentPage,
          items:const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
            label: 'Cart',),
          ]
      ),
    );
  }
}

