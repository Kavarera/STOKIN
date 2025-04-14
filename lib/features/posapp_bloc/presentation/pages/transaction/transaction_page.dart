import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/product_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/domain/entities/transaction_item_entity.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/bloc/transaction/transaction_bloc.dart';

import '../../../domain/entities/transaction_entity.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transaction = GoRouterState.of(context).extra as TransactionEntity?;

    // Trigger event hanya kalau transaksi belum diinit (gunakan state untuk guard)
    final isInitialized = context.select<TransactionBloc, bool>(
      (bloc) => bloc.state.transaction != null,
    );

    if (transaction != null && !isInitialized) {
      context.read<TransactionBloc>().add(
        TransactionEventInitTransactionEvent(transaction: transaction),
      );
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Text(
              state.isUpdate ? 'Update' : 'Create',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                letterSpacing: 2,
                color: Colors.white,
              ),
            );
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state.products.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          key: ValueKey(state.products[index].id),
                          title: Text(state.products.elementAt(index).name),
                          subtitle: Text(
                            state.products.elementAt(index).price.toString(),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  log(
                                    'remove clicked',
                                    name: 'TransactionPage',
                                  );
                                  context.read<TransactionBloc>().add(
                                    TransactionEventProductQuantityDecreaseEvent(
                                      state.products.elementAt(index),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 5),
                              Text(
                                state.cartItems
                                    .firstWhere(
                                      (e) =>
                                          e.product.id ==
                                          state.products[index].id,
                                      orElse:
                                          () => TransactionItemEntity(
                                            product: state.products[index],
                                            quantity: 0,
                                          ),
                                    )
                                    .quantity
                                    .toString(),
                              ),

                              const SizedBox(width: 5),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  log('add clicked', name: 'TransactionPage');
                                  context.read<TransactionBloc>().add(
                                    TransactionEventProductQuantityIncreaseEvent(
                                      state.products.elementAt(index),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: Text('No products found'));
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  return Text(
                    'Total: ${state.totalPrice}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<TransactionBloc>().add(
                        TransactionEventUpdateTransactionEvent(),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(state.isUpdate ? 'Update' : 'Create'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
