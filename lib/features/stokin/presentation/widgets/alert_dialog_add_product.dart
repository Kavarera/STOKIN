import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

class AlertDialogAddProduct extends StatefulWidget {
  const AlertDialogAddProduct({super.key, this.productEntity});
  final ProductEntity? productEntity;
  @override
  State<AlertDialogAddProduct> createState() => _AlertDialogAddProductState();
}

class _AlertDialogAddProductState extends State<AlertDialogAddProduct> {
  late TextEditingController _nameController;
  late TextEditingController _qtyController;
  late TextEditingController _unitController;
  CategoryEntity? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.productEntity?.name ?? '',
    );
    _qtyController = TextEditingController(
      text: widget.productEntity?.quantity.toString() ?? '',
    );
    _unitController = TextEditingController(
      text: widget.productEntity?.unit ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _qtyController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final quantity = int.tryParse(_qtyController.text.trim()) ?? 0;
    final unit = _unitController.text.trim();
    if (name.isEmpty || unit.isEmpty) return;
    if (widget.productEntity != null) {
      context.read<HomeBloc>().add(
        HomeEventUpdateProduct(
          widget.productEntity!.copyWith(
            name:
                name.isEmpty
                    ? widget.productEntity!.name
                    : _nameController.text,
            quantity:
                quantity < 0
                    ? widget.productEntity!.quantity
                    : int.tryParse(_qtyController.text.trim()) ?? 0,
            unit:
                unit.isEmpty
                    ? widget.productEntity!.unit
                    : _unitController.text,
            category: _selectedCategory ?? widget.productEntity!.category,
          ),
        ),
      );
    } else {
      context.read<HomeBloc>().add(
        HomeEventAddProduct(
          ProductEntity(
            id: 0,
            name: name,
            quantity: quantity,
            unit: unit,
            category: _selectedCategory,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('alertDialogAddProduct'), // for testing purposes
      title: Center(
        child: Text(
          widget.productEntity == null ? 'Add Product' : 'Update Product',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('productNameField'), // for testing purposes
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            key: const Key('productQuantityField'), // for testing purposes
            controller: _qtyController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            key: const Key('productUnitField'), // for testing purposes
            controller: _unitController,
            decoration: InputDecoration(labelText: 'Unit'),
          ),
          const SizedBox(height: 10),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              List<CategoryEntity> categories;
              if (state is HomeStateLoadedProducts) {
                categories = state.categories;
              } else if (state is HomeStateLoadedCategories) {
                categories = state.categories;
              } else if (state is HomeStateLoadedTransactions) {
                categories = state.categories;
              } else {
                categories = [];
              }

              if (categories.isNotEmpty) {
                return DropdownButtonFormField<CategoryEntity>(
                  key: const Key('productCategoryField'),
                  decoration: InputDecoration(labelText: 'Category'),
                  items:
                      categories
                          .map(
                            (c) => DropdownMenuItem<CategoryEntity>(
                              key: Key(c.id.toString()),
                              value: c,
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedCategory = value;
                    }
                  },
                  value: _selectedCategory,
                );
              } else {
                return Text('No Categories');
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          key: const Key('addProductButton'),
          onPressed: () async {
            await _submit();
            context.read<HomeBloc>().add(HomeEventGetItems());
            Navigator.of(context).pop();
          },
          child: Text(widget.productEntity == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
