import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stokin/features/stokin/domain/entities/transaction_entity.dart';
import 'package:stokin/features/stokin/presentation/pages/home/controllers/home_controller.dart';

class TransactionListTileWidget extends StatelessWidget {
  const TransactionListTileWidget({
    super.key,
    required this.item,
    required this.controller,
  });

  final TransactionEntity item;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.product.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Amount: ${item.amount}"),
          Text("Date: ${DateFormat('dd MMM yyyy HH:mm').format(item.date)}"),
          Text("Type: ${item.type.name}"),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          controller.deleteItem(item);
        },
      ),
    );
  }
}
