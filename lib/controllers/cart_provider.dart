

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:online_shop/cart/get_products.dart';

class CartProvider with ChangeNotifier{
final _cartBox = Hive.box('cart_box');

List<dynamic> _cart = [];
List<dynamic> get  cart => _cart;

set cart(List<dynamic> newCart){
  _cart = newCart;
  notifyListeners();
}

getCart(){
  List<dynamic> cart = [];
  final cartData = _cartBox.keys.map((key) {
    final item = _cartBox.get(key);
    return {
      "key": key,
      "id": item['id'],
      "category": item['category'],
      "name": item['name'],
      "imageUrl": item['imageUrl'],
      "price": item['price'],
      "qty": item['qty'],
      "sizes": item['sizes']
    };
  }).toList();

  _cart = cartData.reversed.toList();
}

  int _counter =0;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }

  void decrement(){
    if(_counter>=1){
      _counter--;
      notifyListeners();
    }
  }
  Future<void> deletecart(int key) async{
    await _cartBox.delete(key);
  }

  int? _productIndex;

  int get productIndex => _productIndex ?? 0 ;

   set setProductIndex(int newState){
    _productIndex = newState;
    notifyListeners();
  }

  List<Product> _checkout = [];

  List<Product> get checkout => _checkout ;

  set setCheckOutList(List<Product> newState){
    _checkout = newState;
    notifyListeners();
  }

}