import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/category_entity.dart';

import '../bloc/home/home_bloc.dart';

class CategoryListTileWidget extends StatelessWidget {
  final CategoryEntity item;
  CategoryListTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      trailing: IconButton(
        key: Key('deleteCategoryButton_${item.name}'), // for testing purposes
        icon: const Icon(Icons.delete),
        onPressed: () {
          context.read<HomeBloc>().add(HomeEventDeleteCategory(item.id!));
        },
      ),
    );
  }
}
