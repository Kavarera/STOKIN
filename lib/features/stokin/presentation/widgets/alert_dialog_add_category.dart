import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/category_entity.dart';

import '../bloc/home/home_bloc.dart';

class AlertDialogAddCategory extends StatefulWidget {
  const AlertDialogAddCategory({super.key});

  @override
  State<AlertDialogAddCategory> createState() => _AlertDialogAddCategoryState();
}

class _AlertDialogAddCategoryState extends State<AlertDialogAddCategory> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('addCategoryDialog'), // for testing purposes
      title: const Center(child: Text('Add Category')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('categoryNameField'), // for testing purposes
            controller: nameController,
            decoration: InputDecoration(labelText: 'Category Name'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          key: const Key('addCategoryButton'), // for testing purposes
          onPressed: () {
            if (nameController.text.isNotEmpty) {
              CategoryEntity category = CategoryEntity(
                id: 0,
                name: nameController.text.trim(),
              );
              context.read<HomeBloc>().add(HomeEventAddCategory(category));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
