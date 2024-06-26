import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/orders_controller.dart';
import 'package:lesson64_statemanagement/views/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController =
        Provider.of<OrdersController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: ordersController.orders.length,
        itemBuilder: (context, index) {
          return OrderItem(
            product: ordersController.orders[index],
          );
        },
      ),
    );
  }
}
