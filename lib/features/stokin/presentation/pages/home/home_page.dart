import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/widgets/expandable_fab.dart';

import '../../../../../cores/configurations/custom_theme.dart';
import '../../../../../cores/data/menu_type_enum.dart';
import '../../widgets/home_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(HomeEventGetItems());
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
              onPressed: () {},
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        key: const Key(
                          'productsViewButton',
                        ), // for testing purposes
                        onPressed: () {
                          context.read<HomeBloc>().add(
                            const HomeEventChangeMenuView(MenuType.PRODUCTS),
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
                          'categoriesViewButton',
                        ), // for testing purposes
                        onPressed: () {
                          context.read<HomeBloc>().add(
                            const HomeEventChangeMenuView(MenuType.CATEGORIES),
                          );
                        },
                        style: Theme.of(
                          context,
                        ).elevatedButtonTheme.style?.copyWith(
                          backgroundColor:
                              state.menuType == MenuType.CATEGORIES
                                  ? WidgetStateProperty.all(
                                    CustomTheme.secondaryColor,
                                  )
                                  : null,
                        ),
                        child: Text("Categories"),
                      ),
                      ElevatedButton(
                        key: const Key(
                          'transactionsViewButton',
                        ), // for testing purposes
                        onPressed: () {
                          context.read<HomeBloc>().add(
                            const HomeEventChangeMenuView(
                              MenuType.TRANSACTIONS,
                            ),
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
            Expanded(child: HomeListWidget()),
          ],
        ),
      ),
    );
  }
}
