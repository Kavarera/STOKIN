import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/presentation/pages/report/controller/report_controller.dart';

class AlertDialogPickProduct extends StatelessWidget {
  const AlertDialogPickProduct({super.key, required this.controller});

  final ReportController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a Product'),
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.selectedProductId.value != 0
                  ? 'Selected: ${controller.products.firstWhereOrNull((p) => p.id == controller.selectedProductId.value)?.name ?? "Unknown"}'
                  : 'No product selected',
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Select Product'),
              value:
                  controller.selectedProductId.value != 0
                      ? controller.selectedProductId.value
                      : null,
              onChanged: (int? newProductId) {
                if (newProductId != null) {
                  controller.updateSelectedProduct(newProductId);
                  Get.back();
                }
              },
              items:
                  controller.products.map((product) {
                    return DropdownMenuItem<int>(
                      value: product.id,
                      child: Text(
                        '${product.name} - ${product.category?.name ?? "No Category"}',
                      ),
                    );
                  }).toList(),
            ),
          ],
        );
      }),
      actions: [
        TextButton(
          onPressed: () {
            controller.updateSelectedProduct(0);
            Get.back();
          },
          child: Text('Clear'),
        ),
      ],
    );
  }
}
