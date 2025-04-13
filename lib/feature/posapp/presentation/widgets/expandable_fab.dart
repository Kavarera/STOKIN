import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posapp/feature/posapp/presentation/routes/app_pages.dart';
import '../pages/home/controllers/home_controller.dart';
import 'alert_dialog_add_product.dart';

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
                const SizedBox(height: 10),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset:
                      controller.isExpandedFab.value
                          ? Offset.zero
                          : const Offset(0, 1),
                  child: FloatingActionButton(
                    key: const Key('product_fab'), // for testing purposes
                    heroTag: 'product_fab',
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
                    key: const Key('transaction_fab'), // for testing purposes
                    heroTag: 'transaction_fab',
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
            key: const Key('main_fab'), // for testing purposes
            heroTag: 'main_fab',
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
    if (i == 2) {
      controller.isExpandedFab.value = false;
      Get.dialog(
        AlertDialogAddProduct(isUpdate: false, homeController: controller),
      );
    } else if (i == 3) {
      Get.toNamed(Routes.TRANSACTION)?.then((_) {
        controller.loadTransactions();
        controller.isExpandedFab.value = false;
      });
    }
  }
}
