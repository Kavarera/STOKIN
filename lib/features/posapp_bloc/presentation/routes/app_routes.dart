import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:posapp_bloc/features/posapp_bloc/presentation/bloc/transaction/transaction_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../bloc/home/fab_cubit.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/report/report_bloc.dart';
import '../pages/home/home_page.dart';
import '../pages/report/report_page.dart';
import '../pages/transaction/transaction_page.dart';

class AppRoutes {
  get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => DependencyInjection.get<HomeBloc>(),
                ),
                BlocProvider(
                  create: (_) => DependencyInjection.get<FabCubit>(),
                ),
              ],
              child: HomePage(),
            ),
      ),

      GoRoute(
        path: '/transaction',
        name: 'transaction',
        builder:
            (context, state) => BlocProvider(
              create: (_) => DependencyInjection.get<TransactionBloc>(),
              child: const TransactionPage(),
            ),
      ),

      GoRoute(
        path: '/reports',
        name: 'reports',
        builder:
            (context, state) => BlocProvider(
              create: (_) => DependencyInjection.get<ReportBloc>(),
              child: const ReportPage(),
            ),
      ),
    ],
  );
}
