import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/domain/entities/transaction_entity.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';

class TransactionListTileWidget extends StatelessWidget {
  final TransactionEntity item;
  const TransactionListTileWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Amount: ${item.amount}"),
          Text("Date: ${item.date}"),
          Text("Type: ${item.type.name}"),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          context.read<HomeBloc>().add(
            HomeEventDeleteTransaction(item.id, item.amount, item.product),
          );
        },
      ),
    );
  }
}
