import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/products_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:lesson64_statemanagement/views/screens/cart_screen.dart';
import 'package:lesson64_statemanagement/views/screens/order_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Provider.of<ProductsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const OrderScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.content_paste_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const CartScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productsController.list.length,
        itemBuilder: (ctx, index) {
          final product = productsController.list[index];
          return ChangeNotifierProvider<Product>.value(
            value: product,
            builder: (context, child) {
              return ProductItem(
                isCartScreen: false,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic> data = await showDialog(
            context: context,
            builder: (context) => AddAllertDialog(),
          );

          productsController.addProduct(
            title: data["title"],
            price: data["price"],
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AddAllertDialog extends StatelessWidget {
  AddAllertDialog({super.key});

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  String? title;
  double? price;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Product"),
      content: Form(
        key: keyForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please do not leave the field empty";
                }
                return null;
              },
              onSaved: (value) {
                title = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Price"),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please do not leave the field empty";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  price = double.tryParse(value);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (keyForm.currentState!.validate()) {
              keyForm.currentState!.save();
              Navigator.pop(context, {
                "title": title,
                "price": price,
              });
            }
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
