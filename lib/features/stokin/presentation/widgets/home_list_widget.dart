import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/cores/data/menu_type_enum.dart';
import '../bloc/home/home_bloc.dart';
import 'category_list_tile_widget.dart';
import 'product_list_tile_widget.dart';
import 'transaction_list_tile_widget.dart';

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        if (previous.runtimeType != current.runtimeType) return true;

        // Cek perubahan isi list atau menuType
        if (current is HomeStateLoadedProducts &&
            previous is HomeStateLoadedProducts) {
          return current.products != previous.products ||
              current.categories != previous.categories ||
              current.menuType != previous.menuType;
        }

        return false;
      },
      builder: (context, state) {
        if (state is HomeStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeStateError) {
          return Center(child: Text(state.message));
        } else if (state is HomeStateItemEmpty) {
          return const Center(child: Text("No items found."));
        }
        return ListView.builder(
          itemCount:
              state is HomeStateLoadedProducts
                  ? state.products.length
                  : state is HomeStateLoadedCategories
                  ? state.categories.length
                  : state is HomeStateLoadedTransactions
                  ? state.transactions.length
                  : 0,
          itemBuilder: (context, index) {
            if (state is HomeStateLoadedProducts &&
                state.menuType == MenuType.PRODUCTS) {
              return ProductListTileWidget(product: state.products[index]);
            } else if (state is HomeStateLoadedCategories &&
                state.menuType == MenuType.CATEGORIES) {
              return CategoryListTileWidget(item: state.categories[index]);
            } else if (state is HomeStateLoadedTransactions &&
                state.menuType == MenuType.TRANSACTIONS) {
              return TransactionListTileWidget(item: state.transactions[index]);
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
