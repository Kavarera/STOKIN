import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';

class AlertDialogPickProduct extends StatelessWidget {
  final List<ProductEntity> products;
  final int? selectedProductId;
  final void Function(int productId) onPick;
  const AlertDialogPickProduct({
    super.key,
    required this.products,
    required this.selectedProductId,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    ProductEntity? selectedProduct;
    try {
      selectedProduct = products.firstWhere((p) => p.id == selectedProductId);
    } catch (_) {
      selectedProduct = null;
    }
    return AlertDialog(
      title: const Text('Pick a Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedProductId != null
                ? 'Selected: ${selectedProduct?.name}'
                : 'No product selected',
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            decoration: const InputDecoration(labelText: 'Select Product'),
            value: selectedProductId != 0 ? selectedProductId : null,
            onChanged: (newProductId) {
              if (newProductId != null) {
                onPick(newProductId);
                Navigator.of(context).pop();
              }
            },
            items:
                products.map((product) {
                  return DropdownMenuItem<int>(
                    value: product.id,
                    child: Text(
                      '${product.name} - ${product.category?.name ?? "No Category"}',
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            onPick(0);
            Navigator.pop(context);
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }
}
