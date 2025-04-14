import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posapp_bloc/core/configs/custom_theme.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/widgets/expandable_fab.dart';

import '../../../../../core/data/menu_type_enum.dart';
import '../../widgets/alert_dialog_add_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                context.push('/reports');
              },
              icon: const Icon(Icons.analytics, color: Colors.white),
            ),
          ],
        ),
        floatingActionButton: ExpandableFab(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        key: const Key(
                          'productsViewButton',
                        ), // for testing purposes
                        onPressed: () {
                          context.read<HomeBloc>().add(
                            HomeEventChangeMenuType(MenuType.PRODUCTS),
                          );
                        },
                        style: Theme.of(
                          context,
                        ).elevatedButtonTheme.style?.copyWith(
                          backgroundColor:
                              state.menuType == MenuType.PRODUCTS
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
                        onPressed: () {
                          log('Transactions button pressed', name: 'HomePage');
                          context.read<HomeBloc>().add(
                            HomeEventChangeMenuType(MenuType.TRANSACTIONS),
                          );
                        },
                        style: Theme.of(
                          context,
                        ).elevatedButtonTheme.style?.copyWith(
                          backgroundColor:
                              state.menuType == MenuType.TRANSACTIONS
                                  ? WidgetStateProperty.all(
                                    CustomTheme.secondaryColor,
                                  )
                                  : null,
                        ),
                        child: Text("Transactions"),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeStateLoadedItems) {
                    if (state.menuType == MenuType.PRODUCTS) {
                      if (state.products.isEmpty) {
                        return Center(child: Text('No products found'));
                      }
                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.products[index].name),
                            subtitle: Text(
                              'Price: ${state.products[index].price}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (_) => BlocProvider.value(
                                            value: context.read<HomeBloc>(),
                                            child: AlertDialogAddProduct(
                                              productEntity:
                                                  state.products[index],
                                            ),
                                          ),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      HomeEventDeleteItem(index),
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state.menuType == MenuType.TRANSACTIONS) {
                      if (state.transactions.isEmpty) {
                        return Center(child: Text('No transactions found'));
                      }
                      return ListView.builder(
                        itemCount: state.transactions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              state.transactions[index].date.toIso8601String(),
                            ),
                            subtitle: Text(
                              'Price: ${state.transactions[index].totalAmount}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final transaction =
                                        state.transactions[index];
                                    await GoRouter.of(
                                      context,
                                    ).push('/transaction', extra: transaction);
                                    context.read<HomeBloc>().add(
                                      HomeEventGetItems(MenuType.TRANSACTIONS),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      HomeEventDeleteItem(index),
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Center(child: Text('No items found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
