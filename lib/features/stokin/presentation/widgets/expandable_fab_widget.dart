import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/features/stokin/presentation/pages/home/controllers/home_controller.dart';
import 'package:stokin/features/stokin/presentation/widgets/alert_dialog_add_product.dart';

import 'alert_dialog_add_category.dart';
import 'alert_dialog_add_transaction.dart';

class ExpandableFAB extends StatelessWidget {
  final HomeController controller;

  const ExpandableFAB({required this.controller, super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.bottomRight,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: controller.isExpandedFab.value ? 1 : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSlide(
                  duration: const Duration(milliseconds: 150),
                  offset:
                      controller.isExpandedFab.value
                          ? Offset.zero
                          : const Offset(0, 1), // Dari bawah ke atas
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      _showItemAddDialog(context, controller, 1);
                    },
                    child: const Icon(Icons.folder_open_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset:
                      controller.isExpandedFab.value
                          ? Offset.zero
                          : const Offset(0, 1),
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      _showItemAddDialog(context, controller, 2);
                    },
                    child: const Icon(Icons.inventory_2_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset:
                      controller.isExpandedFab.value
                          ? Offset.zero
                          : const Offset(0, 1),
                  child: FloatingActionButton(
                    onPressed: () {
                      _showItemAddDialog(context, controller, 3);
                    },
                    mini: true,
                    child: const Icon(Icons.receipt_long_outlined),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              controller.isExpandedFab.value = !controller.isExpandedFab.value;
            },
            child: Icon(
              controller.isExpandedFab.value ? Icons.close : Icons.add,
            ),
          ),
        ],
      ),
    );
  }

  void _showItemAddDialog(
    BuildContext context,
    HomeController controller,
    int i,
  ) {
    if (i == 1) {
      Get.dialog(AlertDialogAddCategory(homeController: controller));
    } else if (i == 2) {
      Get.dialog(
        AlertDialogAddProduct(isUpdate: false, homeController: controller),
      );
    } else if (i == 3) {
      Get.dialog(AlertDialogAddTransaction(controller: controller));
    }
  }
}
