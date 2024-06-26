import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/orders_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderItem extends StatelessWidget {
  Product product;
  OrderItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<OrdersController>(
        builder: (context, controller, child) {
          print(product.title);
          return TextButton(
            onPressed: () {
              controller.cancelOrder(product.id);
            },
            child: const Text("Cancel"),
          );
        },
      ),
    );
  }
}
