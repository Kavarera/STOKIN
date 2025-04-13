import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/transaction_entity.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          controller.isUpdate ? 'Update' : 'Create',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child:
                    controller.products.isNotEmpty
                        ? ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.products[index].name),
                              subtitle: Text(
                                'Price: ${controller.products[index].price}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      controller.removeProductFromCart(
                                        controller.products[index],
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  Obx(() {
                                    final qty = controller.getQuantity(
                                      controller.products[index],
                                    );
                                    return Text('$qty');
                                  }),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      controller.addProductToCart(
                                        controller.products[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No products available")),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total: ", style: Theme.of(context).textTheme.titleMedium),
                Obx(() {
                  return Text(
                    controller.getTotalPriceCart().toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.isUpdate && controller.transaction != null) {
                      controller.updateTransaction(controller.transaction!);
                    } else {
                      controller.insertTransaction();
                    }
                    Get.back();
                  },
                  child: Text(controller.isUpdate ? 'Update' : 'Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
