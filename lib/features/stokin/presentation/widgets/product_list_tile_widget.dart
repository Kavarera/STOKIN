import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/domain/entities/product_entity.dart';

import '../pages/home/controllers/home_controller.dart';
import 'alert_dialog_add_product.dart';

class ProductListTileWidget extends StatelessWidget {
  const ProductListTileWidget({
    super.key,
    required this.product,
    required this.controller,
  });

  final ProductEntity product;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    log('category: ${product.category?.id}', name: "PRODUCLISTTILEWIDGET");
    return ListTile(
      title: Text(product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Stok: ${product.quantity}"),
          Text("Unit: ${product.unit}"),
          Text("Category: ${product.category?.name}"),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle delete action
              Get.dialog(
                AlertDialogAddProduct(
                  homeController: controller,
                  isUpdate: true,
                  product: product,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete action
              controller.deleteItem(product);
            },
          ),
        ],
      ),
    );
  }
}
