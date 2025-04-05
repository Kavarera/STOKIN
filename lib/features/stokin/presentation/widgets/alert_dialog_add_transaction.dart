import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/transaction_entity.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';

import '../../../../cores/data/transaction_type_enum.dart';
import '../../domain/entities/product_entity.dart';

class AlertDialogAddTransaction extends StatefulWidget {
  const AlertDialogAddTransaction({super.key});

  @override
  State<AlertDialogAddTransaction> createState() =>
      _AlertDialogAddTransactionState();
}

class _AlertDialogAddTransactionState extends State<AlertDialogAddTransaction> {
  final TextEditingController quantityController = TextEditingController();
  var tt = TransactionType.KELUAR;
  ProductEntity? selectedProduct;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('addTransactionDialog'), // for testing purposes
      title: const Center(child: Text('Add Transaction')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              log('state: $state', name: 'AlertDialogAddTransaction');
              List<ProductEntity> products = [];
              if (state is HomeStateLoadedProducts) {
                products = state.products;
              } else if (state is HomeStateLoadedTransactions) {
                products = state.products;
              } else {
                context.read<HomeBloc>().add(const HomeEventLoadProductsOnly());
              }
              if (products.isNotEmpty) {
                return DropdownButtonFormField<ProductEntity>(
                  key: const Key('productField'), // for testing purposes
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
                  value: selectedProduct,
                  items:
                      products
                          .map(
                            (product) => DropdownMenuItem<ProductEntity>(
                              key: Key('${product.id}'), // for testing purposes
                              value: product,
                              child: Text(
                                "${product.name} - ${product.category?.name ?? 'N/A'}",
                              ),
                            ),
                          )
                          .toList(),
                );
              } else {
                return const Text('No products available');
              }
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<TransactionType>(
            key: const Key('transactionTypeField'), // for testing purposes
            decoration: const InputDecoration(labelText: 'Transaction Type'),
            onChanged: (value) {
              if (value != null) {
                tt = value;
              }
            },
            value: tt,
            items:
                TransactionType.values
                    .map(
                      (type) => DropdownMenuItem<TransactionType>(
                        key: Key(
                          'transactionType-${type.name}',
                        ), // for testing purposes
                        value: type,
                        child: Text(type.name),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 10),
          TextField(
            key: const Key('quantityField'), // for testing purposes
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Quantity'),
          ),
        ],
      ),
      actions: [
        TextButton(
          key: const Key('cancelButton'), // for testing purposes
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          key: const Key('addTransactionButton'), // for testing purposes
          onPressed: () {
            if (selectedProduct != null) {
              context.read<HomeBloc>().add(
                HomeEventAddTransaction(
                  TransactionEntity(
                    id: 0,
                    product: selectedProduct!,
                    type: tt,
                    amount:
                        int.tryParse(
                          double.tryParse(
                                quantityController.text.trim(),
                              )?.floor().toString() ??
                              "0",
                        ) ??
                        0,
                    date: DateTime.now(),
                  ),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add Transaction'),
        ),
      ],
    );
  }
}
