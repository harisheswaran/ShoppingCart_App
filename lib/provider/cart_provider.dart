import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String,dynamic>> cart =[];

  void addCart(Map<String,dynamic> product){
    cart.add(product);
    notifyListeners();
  }
  void removeCart(Map<String,dynamic> product){
    cart.remove(product);
    notifyListeners();
  }
}