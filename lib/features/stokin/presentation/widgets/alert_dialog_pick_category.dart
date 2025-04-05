import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';

class AlertDialogPickCategory extends StatelessWidget {
  final List<CategoryEntity> categories;
  final int? selectedCategoryId;
  final Function(int) onPick;

  const AlertDialogPickCategory({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    CategoryEntity? selected;
    try {
      categories.firstWhere((c) => c.id == selectedCategoryId);
    } catch (_) {
      selected = null;
    }
    return categories.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : AlertDialog(
          title: const Text('Pick a Category'),
          content: DropdownButtonFormField<CategoryEntity>(
            decoration: const InputDecoration(labelText: 'Pick Category'),
            value: selected,
            onChanged: (newValue) {
              if (newValue != null) {
                onPick(newValue.id!);
                Navigator.of(context).pop(newValue.id);
              }
            },
            items:
                categories.map((value) {
                  return DropdownMenuItem<CategoryEntity>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                onPick(0);
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
          ],
        );
  }
}
