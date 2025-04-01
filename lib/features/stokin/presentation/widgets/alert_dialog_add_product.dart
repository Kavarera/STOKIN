import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';

import '../../domain/entities/product_entity.dart';
import '../pages/home/controllers/home_controller.dart';

// ignore: must_be_immutable
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
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  CategoryEntity? scategoryEntity = null;
  @override
  Widget build(BuildContext context) {
    if (isUpdate) {
      nameController.text = product?.name ?? '';
      quantityController.text = product?.quantity.toString() ?? '';
      unitController.text = product?.unit ?? 'Pcs';
    }
    return AlertDialog(
      title: Center(child: Text(isUpdate ? 'Update Product' : 'Add Product')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: unitController,
            decoration: InputDecoration(labelText: 'Unit'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<CategoryEntity>>(
            future: homeController.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading categories');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text('No categories available');
              } else {
                return DropdownButtonFormField<CategoryEntity>(
                  decoration: InputDecoration(labelText: 'Category'),
                  items:
                      snapshot.data!
                          .map(
                            (category) => DropdownMenuItem<CategoryEntity>(
                              value: category,
                              child: Text(category.name),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    scategoryEntity = CategoryEntity(
                      id: value?.id,
                      name: value?.name ?? '',
                    );
                  },
                  value: null,
                );
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final name = nameController.text.trim();
            final quantity = int.tryParse(quantityController.text.trim()) ?? 0;
            final unit = unitController.text;
            log(
              'scategory: ${scategoryEntity?.name}',
              name: "ALERTDIALOGADDPRODUCT",
            );
            ProductEntity p = ProductEntity(
              id: product?.id ?? 0,
              name: name,
              quantity: quantity,
              unit: unit,
              category: scategoryEntity,
            );
            if (name.isNotEmpty && quantity > 0) {
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
