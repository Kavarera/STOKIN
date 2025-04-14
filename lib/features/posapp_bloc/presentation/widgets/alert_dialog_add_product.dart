import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../bloc/home/home_bloc.dart';

class AlertDialogAddProduct extends StatefulWidget {
  const AlertDialogAddProduct({super.key, this.productEntity});
  final ProductEntity? productEntity;
  @override
  State<AlertDialogAddProduct> createState() => _AlertDialogAddProductState();
}

class _AlertDialogAddProductState extends State<AlertDialogAddProduct> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.productEntity?.name ?? '',
    );
    _priceController = TextEditingController(
      text: widget.productEntity?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty) {
      return;
    }
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim()) ?? 0;
    if (widget.productEntity != null) {
      context.read<HomeBloc>().add(
        HomeEventUpdateProduct(
          widget.productEntity!.id,
          _nameController.text.trim(),
          _priceController.text.trim(),
        ),
      );
    } else {
      context.read<HomeBloc>().add(HomeEventAddProduct(name, price.toString()));
    }
    Navigator.of(context).pop();
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
            controller: _priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
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
            ;
          },
          child: Text(widget.productEntity == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
