import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:posapp/core/configs/custom_theme.dart';
import 'package:posapp/feature/posapp/presentation/widgets/alert_dialog_pick_month.dart';

import '../controllers/report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            'POSAPP',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Obx(
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
                    backgroundColor:
                        controller.selectedDate.value != null
                            ? WidgetStateProperty.all(
                              CustomTheme.secondaryColor,
                            )
                            : WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: Text('By Month'),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () =>
                    controller.transactions.isNotEmpty
                        ? ListView.builder(
                          itemCount: controller.transactions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                controller.transactions
                                    .elementAt(index)
                                    .date
                                    .toString(),
                              ),
                              subtitle: Text(
                                'Price: ${controller.transactions.elementAt(index).totalAmount}',
                              ),
                            );
                          },
                        )
                        : const Center(child: Text('No transactions found')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
