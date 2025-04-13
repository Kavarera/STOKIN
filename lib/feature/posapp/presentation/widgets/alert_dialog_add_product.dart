import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/product_entity.dart';
import '../pages/home/controllers/home_controller.dart';

class AlertDialogAddProduct extends StatelessWidget {
  final HomeController homeController;
  final bool isUpdate;
  final ProductEntity? product;

  AlertDialogAddProduct({
    super.key,
    required this.homeController,
    this.isUpdate = false,
    this.product,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      nameController.text = product?.name ?? '';
      priceController.text = product?.price.toString() ?? '';
    }
    return AlertDialog(
      key: const Key('addProductDialog'), // for testing purposes
      title: Center(child: Text(isUpdate ? 'Update Product' : 'Add Product')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('productNameField'), // for testing purposes
            controller: nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            key: const Key('productpriceField'), // for testing purposes
            controller: priceController,
            decoration: InputDecoration(labelText: 'price'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          key: const Key('addProductButton'), // for testing purposes
          onPressed: () {
            final name = nameController.text.trim();
            final price = double.tryParse(priceController.text.trim()) ?? 0;
            ProductEntity p = ProductEntity(
              id: product?.id ?? 0,
              name: name,
              price: price,
            );
            if (name.isNotEmpty && price > 0) {
              if (isUpdate) {
                homeController.updateProduct(p);
              } else {
                homeController.addProduct(p);
              }
              Get.back();
            } else {
              Get.snackbar('Error', 'Please fill in all fields correctly');
            }
          },
          child: Text(isUpdate ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
