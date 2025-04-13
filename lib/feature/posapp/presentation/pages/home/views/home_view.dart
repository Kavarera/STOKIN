import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posapp/feature/posapp/presentation/routes/app_pages.dart';
import 'package:posapp/feature/posapp/presentation/widgets/alert_dialog_add_product.dart';
import 'package:posapp/feature/posapp/presentation/widgets/expandable_fab.dart';

import '../../../../../../core/configs/custom_theme.dart';
import '../../../../../../core/data/menu_type_enum.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'POSAPP',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // TODO: Implement NAVIGATION TO REPORTS PAGE
                Get.toNamed(Routes.REPORT);
              },
              icon: const Icon(Icons.analytics, color: Colors.white),
            ),
          ],
        ),
        floatingActionButton: ExpandableFAB(controller: controller),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      key: const Key(
                        'productsViewButton',
                      ), // for testing purposes
                      onPressed:
                          () => controller.changeListType(MenuType.PRODUCTS),
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            controller.listType.value == MenuType.PRODUCTS
                                ? WidgetStateProperty.all(
                                  CustomTheme.secondaryColor,
                                )
                                : null,
                      ),
                      child: Text("Products"),
                    ),
                    ElevatedButton(
                      key: const Key(
                        'transactionsViewButton',
                      ), // for testing purposes
                      onPressed:
                          () =>
                              controller.changeListType(MenuType.TRANSACTIONS),
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            controller.listType.value == MenuType.TRANSACTIONS
                                ? WidgetStateProperty.all(
                                  CustomTheme.secondaryColor,
                                )
                                : null,
                      ),
                      child: Text("Transactions"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () =>
                    controller.listType.value == MenuType.PRODUCTS
                        ? controller.products.isNotEmpty
                            ? ListView.builder(
                              itemCount:
                                  controller.listType.value == MenuType.PRODUCTS
                                      ? controller.products.length
                                      : controller.transactions.length,
                              itemBuilder: (context, index) {
                                if (controller.listType.value ==
                                    MenuType.PRODUCTS) {
                                  return ListTile(
                                    title: Text(
                                      controller.products[index].name,
                                    ),
                                    subtitle: Text(
                                      'Price: ${controller.products[index].price}',
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Get.dialog(
                                              AlertDialogAddProduct(
                                                homeController: controller,
                                                isUpdate: true,
                                                product: controller.products
                                                    .elementAt(index),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.deleteProduct(
                                              controller.products.elementAt(
                                                index,
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                    title: Text(
                                      controller.transactions[index].id
                                          .toString(),
                                    ),
                                    subtitle: Text(
                                      'Price: ${controller.transactions[index].totalAmount}',
                                    ),
                                  );
                                }
                              },
                            )
                            : Center(child: Text("No products"))
                        : controller.transactions.isNotEmpty
                        ? ListView.builder(
                          itemCount: controller.transactions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                controller.transactions[index].date
                                    .toIso8601String(),
                              ),
                              subtitle: Text(
                                'Price: ${controller.transactions[index].totalAmount}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.TRANSACTION,
                                        arguments: controller.transactions.value
                                            .elementAt(index),
                                      )?.then(
                                        (_) => controller.loadTransactions(),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.deleteTransaction(
                                        controller.transactions.elementAt(
                                          index,
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        : Center(child: Text("No transactions")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
