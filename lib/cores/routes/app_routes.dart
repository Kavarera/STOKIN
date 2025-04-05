import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stokin_bloc/cores/di/dependency_injection.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/home/home_bloc.dart';
import 'package:stokin_bloc/features/stokin/presentation/bloc/report/report_bloc.dart';

import '../../features/stokin/presentation/bloc/home/fab_cubit.dart';
import '../../features/stokin/presentation/pages/home/home_page.dart';
import '../../features/stokin/presentation/pages/report/report_page.dart';

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
