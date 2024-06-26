import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/models/product.dart';

class OrdersController extends ChangeNotifier {
  List<Product> _orders = [];

  List<Product> get orders => _orders;

  void addProdcutsToOrders(Product product) {
    _orders.add(product);
    print("${orders}");
    notifyListeners();
  }

  void cancelOrder(String id) {
    _orders.removeWhere((value) {
      return value.id == id;
    });
    notifyListeners();
  }
}
