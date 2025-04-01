import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokin/core/data/transaction_type_enum.dart';
import 'package:stokin/features/stokin/domain/entities/product_entity.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';
import 'package:stokin/features/stokin/presentation/pages/home/controllers/home_controller.dart';

class AlertDialogAddTransaction extends StatelessWidget {
  final HomeController controller;

  AlertDialogAddTransaction({super.key, required this.controller});
  final TextEditingController quantityController = TextEditingController();
  ProductEntity? selectedProduct = null;
  var tt = TransactionType.KELUAR;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: const Text('Add Transaction')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder<List<ProductEntity>>(
            future: controller.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Error loading products');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No products available');
              } else {
                return DropdownButtonFormField<ProductEntity>(
                  decoration: const InputDecoration(labelText: 'Product'),
                  onChanged: (value) {
                    selectedProduct = ProductEntity(
                      id: value?.id ?? 0,
                      name: value?.name ?? '',
                      unit: value?.unit ?? 'Pcs',
                      quantity: value?.quantity ?? 0,
                      category: value?.category,
                    );
                  },
                  value: null,
                  items:
                      snapshot.data!
                          .map(
                            (product) => DropdownMenuItem<ProductEntity>(
                              value: product,
                              child: Text(
                                "${product.name} - ${product.category?.name ?? 'N/A'}",
                              ),
                            ),
                          )
                          .toList(),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<TransactionType>(
            decoration: const InputDecoration(labelText: 'Transaction Type'),
            onChanged: (value) {
              if (value != null) {
                tt = value;
              }
            },
            value: TransactionType.KELUAR,
            items: [
              DropdownMenuItem<TransactionType>(
                value: TransactionType.KELUAR,
                child: const Text('Keluar'),
              ),
              DropdownMenuItem<TransactionType>(
                value: TransactionType.MASUK,
                child: const Text('Masuk'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Transaction Amount'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final amount = int.tryParse(quantityController.text) ?? 0;
            if (quantityController.text.isNotEmpty || amount > 0) {
              if (selectedProduct != null) {
                final transaction = TransactionEntity(
                  amount: amount,
                  date: DateTime.now(),
                  product: selectedProduct!,
                  type: tt,
                  id: 0,
                );
                controller.addTrasaction(transaction);
                Get.back();
              }
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
