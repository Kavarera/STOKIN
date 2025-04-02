import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:stokin/core/configurations/custom_theme.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';
import 'package:stokin/features/stokin/presentation/routes/app_pages.dart';
import '../../../../../../core/data/menu_type_enum.dart';
import '../../../widgets/alert_dialog_pick_category.dart';
import '../../../widgets/expandable_fab_widget.dart';
import '../../../widgets/home_list_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'STOKIN',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
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
                      onPressed:
                          () => controller.changeListType(MenuType.CATEGORIES),
                      style: Theme.of(
                        context,
                      ).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            controller.listType.value == MenuType.CATEGORIES
                                ? WidgetStateProperty.all(
                                  CustomTheme.secondaryColor,
                                )
                                : null,
                      ),
                      child: Text("Categories"),
                    ),
                    ElevatedButton(
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
              child: Obx(() {
                if (controller.listType.value == MenuType.PRODUCTS) {
                  return HomeListWidget(
                    controller: controller,
                    futureFunction: controller.getProducts,
                  );
                } else if (controller.listType.value == MenuType.CATEGORIES) {
                  return HomeListWidget(
                    controller: controller,
                    futureFunction: controller.getCategories,
                  );
                } else if (controller.listType.value == MenuType.TRANSACTIONS) {
                  return Column(
                    children: [
                      Expanded(
                        child: HomeListWidget(
                          controller: controller,
                          futureFunction: controller.getTransactions,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text("No data found."));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
