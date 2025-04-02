import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stokin/core/data/transaction_type_enum.dart';

import '../../../../../../core/configurations/custom_theme.dart';
import '../../../widgets/alert_dialog_pick_category.dart';
import '../../../widgets/alert_dialog_pick_month.dart';
import '../../../widgets/alert_dialog_pick_product.dart';
import '../controller/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

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
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    controller.updateCategory(0);
                    controller.selectedDate.value = null;
                    controller.selectedProductId.value = 0;
                  },
                  child: Text('All'),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogPickCategory(
                            controller: controller,
                          );
                        },
                      );
                    },
                    style: ButtonStyle().copyWith(
                      backgroundColor:
                          controller.selectedCategoryId.value != 0
                              ? WidgetStateProperty.all(
                                CustomTheme.secondaryColor,
                              )
                              : WidgetStateProperty.all(Colors.transparent),
                    ),
                    child: Text('By Category'),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogPickMonth(controller: controller);
                        },
                      );
                    },
                    style: ButtonStyle().copyWith(
                      backgroundColor: WidgetStateProperty.all(
                        controller.selectedDate.value != null
                            ? CustomTheme.secondaryColor
                            : Colors.transparent,
                      ),
                    ),
                    child: Text('By Month'),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialogPickProduct(controller: controller);
                        },
                      );
                    },
                    style: ButtonStyle().copyWith(
                      backgroundColor: WidgetStateProperty.all(
                        controller.selectedProductId.value != 0
                            ? CustomTheme.secondaryColor
                            : Colors.transparent,
                      ),
                    ),
                    child: Text('By Product'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.transactions.isEmpty) {
                  return Center(child: Text('No transactions available.'));
                }
                return ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions[index];
                    return ListTile(
                      title: Text(transaction.product.name),
                      subtitle: Text(
                        DateFormat('dd MMM yyyy').format(transaction.date),
                      ),
                      trailing: Text(
                        "${transaction.type == TransactionType.MASUK ? '+' : '-'}${transaction.amount.toString()}",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
