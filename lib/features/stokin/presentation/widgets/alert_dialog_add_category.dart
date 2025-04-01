import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';
import 'package:stokin/features/stokin/presentation/pages/home/controllers/home_controller.dart';

class AlertDialogAddCategory extends StatelessWidget {
  final HomeController homeController;

  AlertDialogAddCategory({super.key, required this.homeController});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Add Category')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              CategoryEntity category = CategoryEntity(
                id: 0,
                name: nameController.text,
              );
              homeController.addCategory(category);
              Get.back();
            } else {
              Get.snackbar(
                'Error',
                'Category name cannot be empty',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
