import 'package:flutter/material.dart';
import 'package:stokin/features/stokin/presentation/pages/home/controllers/home_controller.dart';

class CategoryListTileWidget extends StatelessWidget {
  const CategoryListTileWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  final dynamic item;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          controller.deleteItem(item);
        },
      ),
    );
  }
}
