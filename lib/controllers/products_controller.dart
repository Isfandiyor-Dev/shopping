import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/models/product.dart';

class ProductsController extends ChangeNotifier {
  final List<Product> _list = [
    Product(
      // id: UniqueKey().toString(),
      id: "1",
      title: "iPhone",
      color: Colors.teal,
      price: 340.5,
    ),
    Product(
      id: "2",
      title: "Macbook",
      color: Colors.grey,
      price: 1340.5,
    ),
    Product(
      id: "3",
      title: "AirPods",
      color: Colors.blue,
      price: 140.5,
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  void removeFromProducts(String productId) {
    _list.removeWhere((product) {
      print("Products id: ${product.id} $productId");
      return product.id == productId;
    });
    for (var product in _list) {
      print(product.title);
    }
    notifyListeners();
  }

  void editProduct(String productId, String newTitle, double newPrice) {
    for (var product in _list) {
      if (product.id == productId) {
        product.title = newTitle;
        product.price = newPrice;
      }
    }
    // for (var product in _list) {
    //   print(product.title);
    // }
    notifyListeners();
  }

  void addProduct({required String title, required double price}) {
    String newId = "0";
    for (var product in _list) {
      if (int.parse(product.id) > int.parse(newId)) {
        newId = product.id;
      }
    }
    newId = (int.parse(newId) + 1).toString();
    print(newId);

    _list.add(
      Product(
        id: newId,
        title: title,
        color: Colors.primaries[Random().nextInt(17)],
        price: price,
      ),
    );

    for (var product in _list) {
      print(product.title);
    }
    notifyListeners();
  }
}
