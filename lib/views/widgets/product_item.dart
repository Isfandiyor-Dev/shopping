import 'package:flutter/material.dart';
import 'package:lesson64_statemanagement/controllers/cart_controller.dart';
import 'package:lesson64_statemanagement/controllers/orders_controller.dart';
import 'package:lesson64_statemanagement/controllers/products_controller.dart';
import 'package:lesson64_statemanagement/models/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  bool isCartScreen;
  ProductItem({super.key, required this.isCartScreen});

  @override
  Widget build(BuildContext context) {
    final productsController =
        Provider.of<ProductsController>(context, listen: true);
    final product = Provider.of<Product>(context, listen: false);
    final ordersController = Provider.of<OrdersController>(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
      ),
      title: Text(
        product.title,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("\$${product.price}"),
      trailing: Consumer<CartController>(
        builder: (context, controller, child) {
          // print(product.title);
          return controller.isInCart(product.id)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    !isCartScreen
                        ? Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  Map<String, dynamic> data = await showDialog(
                                    context: context,
                                    builder: (context) => EditAllertDialog(
                                      product: product,
                                    ),
                                  );
                                  productsController.editProduct(
                                    product.id,
                                    data["title"],
                                    data["price"],
                                  );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  productsController
                                      .removeFromProducts(product.id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    isCartScreen
                        ? IconButton(
                            onPressed: () {
                              ordersController.addProdcutsToOrders(product);
                            },
                            icon: const Icon(Icons.content_paste_rounded),
                          )
                        : const SizedBox(),
                        
                    IconButton(
                      onPressed: () {
                        controller.removeFromCart(product.id);
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Text(
                      controller.getProductAmount(product.id).toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addToCart(product);
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Map<String, dynamic> data = await showDialog(
                          context: context,
                          builder: (context) => EditAllertDialog(
                            product: product,
                          ),
                        );
                        productsController.editProduct(
                          product.id,
                          data["title"],
                          data["price"],
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        productsController.removeFromProducts(product.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.addToCart(product);
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class EditAllertDialog extends StatelessWidget {
  final Product product;
  EditAllertDialog({super.key, required this.product});

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  String? newTitle;
  double? newPrice;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Product"),
      content: Form(
        key: keyForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: product.title,
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
                newTitle = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.price.toString(),
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
                  newPrice = double.tryParse(value);
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
                "title": newTitle,
                "price": newPrice,
              });
            }
          },
          child: const Text("Save"),
        )
      ],
    );
  }
}
