import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/product_entity.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/widgets/alert_dialog_add_product.dart';

class ProductListTileWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductListTileWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Stok: ${product.quantity}"),
          Text("Unit: ${product.unit}"),
          Text("Category: ${product.category?.name ?? 'N/A'}"),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => BlocProvider.value(
                      value: context.read<HomeBloc>(),
                      child: AlertDialogAddProduct(productEntity: product),
                    ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<HomeBloc>().add(HomeEventDeleteProduct(product.id));
            },
          ),
        ],
      ),
    );
  }
}
