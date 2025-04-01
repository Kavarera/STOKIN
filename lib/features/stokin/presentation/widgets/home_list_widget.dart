import 'package:flutter/material.dart';
import 'package:stokin/features/stokin/domain/entities/category_entity.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';

import '../../domain/entities/product_entity.dart';
import '../pages/home/controllers/home_controller.dart';
import 'category_list_tile_widget.dart';
import 'product_list_tile_widget.dart';
import 'transaction_list_tile_widget.dart';

class HomeListWidget extends StatelessWidget {
  final Future<List<dynamic>> Function() futureFunction;
  const HomeListWidget({
    super.key,
    required this.controller,
    required this.futureFunction,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFunction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Oops! Something went wrong."));
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text("No products found."));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final item = snapshot.data![index];
            if (item is ProductEntity) {
              return ProductListTileWidget(
                product: item,
                controller: controller,
              );
            } else if (item is CategoryEntity) {
              return CategoryListTileWidget(item: item, controller: controller);
            } else if (item is TransactionEntity) {
              return TransactionListTileWidget(
                item: item,
                controller: controller,
              );
            }
            return null;
          },
        );
      },
    );
  }
}
