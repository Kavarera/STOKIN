import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/presentation/pages/report/controller/report_controller.dart';

import '../../domain/entities/category_entity.dart';

class AlertDialogPickCategory extends StatelessWidget {
  const AlertDialogPickCategory({super.key, required this.controller});

  final ReportController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a Category'),
      content: Obx(() {
        if (controller.categories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return DropdownButtonFormField<CategoryEntity>(
          decoration: InputDecoration(labelText: 'Pick Category'),
          value: controller.categories.firstWhereOrNull(
            (c) => c.id == controller.selectedCategoryId.value,
          ),
          onChanged: (CategoryEntity? newValue) {
            if (newValue != null) {
              controller.updateCategory(newValue.id!);
              Get.back();
            }
          },
          items:
              controller.categories.map((value) {
                return DropdownMenuItem<CategoryEntity>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
        );
      }),
      actions: [
        TextButton(
          onPressed: () {
            controller.updateCategory(0);
            Get.back();
          },
          child: Text('Clear'),
        ),
      ],
    );
  }
}
