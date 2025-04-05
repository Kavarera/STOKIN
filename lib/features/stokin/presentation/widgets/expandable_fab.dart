import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/fab_cubit.dart';
import 'package:stokin_bloc/features/stokin/presentation/widgets/alert_dialog_add_product.dart';

import '../bloc/home/home_bloc.dart';
import 'alert_dialog_add_category.dart';
import 'alert_dialog_add_transaction.dart';

class ExpandableFab extends StatelessWidget {
  const ExpandableFab({super.key});

  void _showItemDialog(BuildContext context, int i) async {
    if (i == 1) {
      showDialog(
        context: context,
        builder:
            (_) => BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: const AlertDialogAddCategory(),
            ),
      );
    }
    if (i == 2) {
      showDialog(
        context: context,
        builder:
            (_) => BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: const AlertDialogAddProduct(),
            ),
      );
    }
    if (i == 3) {
      showDialog(
        context: context,
        builder:
            (_) => BlocProvider.value(
              value: context.read<HomeBloc>(),
              child: const AlertDialogAddTransaction(),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FabCubit, bool>(
      builder: (context, isExpanded) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            AnimatedOpacity(
              opacity: isExpanded ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSlide(
                    offset: isExpanded ? Offset.zero : const Offset(0, 1),
                    duration: const Duration(milliseconds: 150),
                    child: FloatingActionButton(
                      key: const Key('category_fab'),
                      onPressed: () {
                        _showItemDialog(context, 1);
                      },
                      heroTag: 'category_fab',
                      mini: true,
                      child: const Icon(Icons.folder_open_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 150),
                    offset: isExpanded ? Offset.zero : Offset(0, 1),
                    child: FloatingActionButton(
                      key: const Key('product_fab'),
                      heroTag: 'product_fab',
                      mini: true,
                      onPressed: () {
                        _showItemDialog(context, 2);
                      },
                      child: const Icon(Icons.inventory_2_outlined),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 150),
                    offset: isExpanded ? Offset.zero : Offset(0, 1),
                    child: FloatingActionButton(
                      key: const Key('transaction_fab'),
                      heroTag: 'transaction_fab',
                      mini: true,
                      onPressed: () {
                        _showItemDialog(context, 3);
                      },
                      child: const Icon(Icons.receipt_long_outlined),
                    ),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
            FloatingActionButton(
              key: const Key('main_fab'),
              heroTag: 'main_fab',
              onPressed: () => context.read<FabCubit>().toggle(),
              child: Icon(isExpanded ? Icons.close : Icons.add),
            ),
          ],
        );
      },
    );
  }
}
