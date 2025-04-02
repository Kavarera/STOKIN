import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../pages/report/controller/report_controller.dart';

class AlertDialogPickMonth extends StatelessWidget {
  const AlertDialogPickMonth({super.key, required this.controller});

  final ReportController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick a Month'),
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.selectedDate.value != null
                  ? 'Selected: ${DateFormat('MMMM yyyy').format(controller.selectedDate.value!)}'
                  : 'No month selected',
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Select Month'),
              value: controller.selectedDate.value?.month,
              onChanged: (int? newMonth) {
                if (newMonth != null) {
                  controller.updateDate(
                    DateTime(DateTime.now().year, newMonth),
                  );
                  Get.back();
                }
              },
              items: List.generate(12, (index) {
                final monthName = DateFormat(
                  'MMMM',
                ).format(DateTime(2000, index + 1));
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Text(monthName),
                );
              }),
            ),
          ],
        );
      }),
      actions: [
        TextButton(
          onPressed: () {
            controller.updateDate(null);
            Get.back();
          },
          child: Text('Clear'),
        ),
      ],
    );
  }
}
